module SofaScore
  module Football
    module Teams
      class GetCountry

        attr_accessor :team_id

        def initialize(team_id)
          @team_id = team_id
        end

        def execute
          binding.pry
        end

        private

        def team
          @_team ||= Team.find team_id
        end

        def url
          "http://www.sofascore.com/ru/team/football/#{team.sofa_score_slug}/#{team.sofa_score_slug}"
        end

      end
    end
  end
end
