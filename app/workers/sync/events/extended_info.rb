module Sync
  module Events
    class ExtendedInfo

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { hourly }

      def perform
        Event.where(venue_id: nil).pluck(:id) {|event_id| Sync::Events::Info.perform_async event_id }
      end

    end
  end
end
