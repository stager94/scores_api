module Sync
  module Competitions
    class Events

      include Sidekiq::Worker

      def perform(competition_id)
        competition = Competition.find competition_id
        ::SofaScore::Football::Competitions::Events.new(competition.seasons.active.id).execute
      end

    end
  end
end
