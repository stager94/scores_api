module SofaScore
  module Football
    module Competitions
      class Events

        attr_reader :season_id

        def initialize(season_id)
          @season_id = season_id
        end

        def execute
          return if !weeks || weeks.empty? || !active_week || (Time.at(active_week["weekStartDate"]).to_date > deadline)
          json["weekMatches"]["tournaments"].each do |tournament_params|
            tournament_params["events"].each do |event_params|
              ::SofaScore::Football::Events::Creating.new(season.competition_id, season_id, event_params).execute
            end
          end
          season.update events_last_load_timestamp: weeks_range[1]
        end

        private

        def weeks
          @_weeks ||= SofaScore::Football::Seasons::WeeksRange.new(season_id).weeks
        end

        def active_week
          current_timestamp = Time.now.to_i
          week = weeks.find {|w| w["weekStartDate"] < current_timestamp && w["weekEndDate"] > current_timestamp }
          week ||= weeks.select {|w| w["weekStartDate"] > current_timestamp }.first
        end

        def active_week_index
          weeks.index active_week
        end

        def last_week
          if weeks[active_week_index+1].nil? || Time.at(weeks[active_week_index+1]["weekStartDate"]).to_date > deadline
            active_week
          else
            weeks[active_week_index+1]
          end
        end

        def weeks_range
          [active_week["weekStartDate"], last_week["weekEndDate"]]
        end

        def season
          @_season ||= Season.find season_id
        end

        def url
          "http://www.sofascore.com/u-tournament/#{season.competition.sofa_score_id}/season/#{season.external_id}/matches/week/#{weeks_range[0]}/#{weeks_range[1]}"
        end

        def json
          @_json ||= JSON.parse Net::HTTP.get_response(URI.parse(url)).body
        end

        def deadline
          Time.now.beginning_of_week.to_date+2.weeks
        end

      end
    end
  end
end
