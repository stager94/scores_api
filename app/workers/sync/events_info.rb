module Sync
  class EventsInfo

    include Sidekiq::Worker
    # include Sidetiq::Schedulable

    # recurrence { hourly.minute_of_hour(*(0..59).step(1).to_a) }

    def perform
      Event.live.each {|event| Sync::Events::Info.perform_async event.id }
      Event.only_score.each {|event| Sync::Events::Info.perform_async event.id }
    end

  end
end
