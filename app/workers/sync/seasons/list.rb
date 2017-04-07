module Sync
  module Seasons
    class List

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { monthly }

      def perform
        Competition.all.pluck(:id).each {|competition_id| SofaScore::Football::Seasons::Synchronizer.new(competition_id).execute }
      end

    end
  end
end
