module Sync
  module Seasons
    class ForCompetition

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { monthly }

      def perform(competition_id)
        SofaScore::Football::Seasons::Synchronizer.new(competition_id).execute
      end

    end
  end
end
