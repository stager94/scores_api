module SofaScore
  module Football
    module Events
      class Creating < SofaScore::Football::Events::Base

        attr_reader :competition_id, :season_id, :params

        def initialize(competition_id, season_id, params)
          @competition_id = competition_id
          @season_id = season_id
          @params    = params
        end

        def execute
          begin
            event = Event.where(external_id: external_id).count > 0
            if event
              event.update update_params
            else
              Event.create create_params
            end
          rescue Exception => e
            binding.pry
            return
          end
        end

        private

        def external_id
          params["id"]
        end

        def home_team
          team = Team.find_by_sofa_score_id params["homeTeam"]["id"]
          team ||= create_team(params["homeTeam"])
        end

        def away_team
          team = Team.find_by_sofa_score_id params["awayTeam"]["id"]
          team ||= create_team(params["awayTeam"])
        end

        def create_team(team_params)
          Team.create title_en: team_params["name"],
                      sofa_score_id: team_params["id"],
                      sofa_score_slug: team_params["slug"],
                      logo: open("http://www.sofascore.com/images/team-logo/football_#{team_params["id"]}.png")
        end

        def create_params
          {
            external_id: external_id,
            home_score: (params["homeScore"]["current"] rescue 0),
            away_score: (params["awayScore"]["current"] rescue 0),
            home_scores: params["homeScore"].is_a?(Array) ? {} : params["homeScore"],
            away_scores: params["awayScore"].is_a?(Array) ? {} : params["awayScore"],
            event_status_id: (find_status || create_status).id,
            name: params["name"],
            started_at: Time.at(params["startTimestamp"]).utc,
            season_id: season_id,
            competition_id: competition_id,
            home_team_id: home_team.id,
            away_team_id: away_team.id
          }
        end

        def update_params
          {
            home_score: (params["homeScore"]["current"] rescue 0),
            away_score: (params["awayScore"]["current"] rescue 0),
            home_scores: params["homeScore"].is_a?(Array) ? {} : params["homeScore"],
            away_scores: params["awayScore"].is_a?(Array) ? {} : params["awayScore"],
            event_status_id: (find_status || create_status).id,
            started_at: Time.at(params["startTimestamp"]).utc
          }
        end

      end
    end
  end
end
