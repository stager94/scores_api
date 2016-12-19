module SofaScore
  module Football
    module Competitions
      class Events

        attr_reader :season_id

        def initialize(season_id)
          @season_id = season_id
        end

        def execute
          return if weeks_range[0] == weeks_range[1] || weeks_range[0].nil?
          json["weekMatches"]["tournaments"].each do |tournament_params|
            tournament_params["events"].each do |event_params|
              ::SofaScore::Football::Events::Creating.new(season_id, event_params).execute
            end
          end
          season.update events_last_load_timestamp: weeks_range[1]
        end

        private

        def weeks_range
          [(season.events_last_load_timestamp || season.start_date).to_i, season.end_date.to_i]
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

      end
    end
  end
end
