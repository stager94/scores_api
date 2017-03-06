module Sync
  module Competitions
    class Events

      include Sidekiq::Worker

      def perform(competition_id)
        competition = Competition.find competition_id
        SofaScore::Football::Seasons::Synchronizer.new(competition_id).execute unless competition.seasons.active
        active_season = competition.reload.seasons.active
        ::SofaScore::Football::Competitions::Events.new(active_season.id).execute if active_season.present?
      end

    end
  end
end
