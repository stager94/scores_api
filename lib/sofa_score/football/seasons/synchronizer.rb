module SofaScore
  module Football
    module Seasons
      class Synchronizer < SofaScore::Football::Base

        attr_reader :competition_id

        def initialize(competition_id)
          @competition_id = competition_id
        end

        def execute
          doc.css('.js-uniqueTournament-page-seasons-select li').each do |season_li|
            is_active = season_li.attributes["class"].value.split(" ").include? "active"
            link = season_li.css("a").first
            external_id = get_html_node_attr link, "data-season-id"

            season = competition.seasons.where(external_id: external_id).first_or_initialize
            next if (season.dates_loaded && !season.is_active?)

            if season.new_record?
              competition.seasons.update_all is_active: false if is_active
              season.update prepare_params(external_id, is_active, link, season.id)
            end
            dr = date_range season.id
            if dr[0] != -1
              season.update start_date: Time.at(dr[0]), end_date: Time.at(dr[1]), dates_loaded: true
            else
              season.update dates_loaded: true
            end
          end
        end

        private

        def competition
          @_competition ||= Competition.find competition_id
        end

        def region
          @_region ||= competition.region
        end

        def url
          "http://www.sofascore.com/ru/tournament/football/#{region.sofa_score_slug}/#{competition.sofa_score_slug}/#{competition.sofa_score_id}"
        end

        def doc
          @_doc ||= Nokogiri::HTML(open(url))
        end

        def date_range(season_id)
          SofaScore::Football::Seasons::WeeksRange.new(season_id).execute
        end

        def prepare_params(external_id, is_active, link, season_id)
          {
            is_active: is_active,
            name: get_html_node_text(link),
            year: get_html_node_text(link),
            external_id: external_id
          }
        end

      end
    end
  end
end
