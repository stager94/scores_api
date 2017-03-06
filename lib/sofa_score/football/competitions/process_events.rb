module SofaScore
  module Football
    module Competitions
      class ProcessEvents

        attr_reader :params, :region

        def initialize(params, region_slug)
          @params = params
          @region = Region.where(sofa_score_slug: region_slug).first
        end

        def execute
          params["events"].each do |event|
            SofaScore::Football::Events::Creating.new(competition.try(:id), season.try(:id), event).execute
          end
        end

        private

        def competition
          @_competition ||= (find_competition || create_competition)
        end

        def season
          @_season ||= (find_season || create_season)
        end

        def find_competition
          if params["tournament"]["uniqueId"].nil?
            Competition.where(sofa_score_id: params["tournament"]["id"]).first
          else
            Competition.where(sofa_score_id: params["tournament"]["uniqueId"]).first
          end
        end

        def find_season
          return if params["season"].nil?
          Season.where(external_id: params["season"]["id"]).first
        end

        def create_competition
          params["tournament"]["uniqueId"].nil? ? create_regular_competition : create_unique_competition
        end

        def create_regular_competition
          region.competitions.create sofa_score_id: params["tournament"]["id"],
                                     sofa_score_slug: params["tournament"]["slug"],
                                     title_en: params["tournament"]["name"]
        end

        def create_unique_competition
          region.competitions.create sofa_score_id: params["tournament"]["uniqueId"],
                                     sofa_score_slug: params["tournament"]["slug"],
                                     title_en: params["tournament"]["uniqueName"],
                                     flag: open("http://www.sofascore.com/u-tournament/#{params["tournament"]["uniqueId"]}/logo")
        end

        def create_season
          return if params["season"].nil?
          s = competition.seasons.create external_id: params["season"]["id"],
                                        is_active: true,
                                        name: params["season"]["name"],
                                        year: params["season"]["year"],
                                        dates_loaded: true
          date_ranges = SofaScore::Football::Seasons::WeeksRange.new(s.id).execute
          s.update start_date: Time.at(date_ranges[0]), end_date: Time.at(date_ranges[1]), dates_loaded: true if date_ranges[0] != -1
          s
        end

      end
    end
  end
end
