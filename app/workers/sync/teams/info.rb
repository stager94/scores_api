module Sync
  module Teams
    class Info

      include Sidekiq::Worker

      def perform(team_id)
        SofaScore::Football::Teams::ExtendedInfo.new(team_id: team_id).run!
      end

    end
  end
end
