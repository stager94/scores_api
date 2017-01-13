module SofaScore
  module Football
    module Seasons
      class WeeksRange

        attr_reader :season_id

        def initialize(season_id)
          @season_id = season_id
        end

        def execute
          date_range rescue [-1, -1]
        end

        def date_range
          [weeks.first["weekStartDate"],weeks.last["weekEndDate"]]
        end

        def weeks
          json["events"]["weeks"]
        end

        private

        def season
          @_season ||= Season.find season_id
        end

        def url
          "http://www.sofascore.com/u-tournament/#{season.competition.sofa_score_id}/season/#{season.external_id}/json"
        end

        def json
          JSON.parse Net::HTTP.get_response(URI.parse(url)).body
        end

      end
    end
  end
end
