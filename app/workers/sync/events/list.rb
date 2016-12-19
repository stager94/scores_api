module Sync
  module Events
    class List

      include Sidekiq::Worker
      include Sidetiq::Schedulable

      recurrence { monthly }

      def perform
        Competition.all.pluck(:id).each {|competition_id| Sync::Competitions::Events.perform_async(competition_id) }
      end

    end
  end
end
