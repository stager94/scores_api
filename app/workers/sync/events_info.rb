module Sync
  class EventsInfo

    include Sidekiq::Worker
    include Sidetiq::Schedulable

    recurrence { hourly.minute_of_hour(*(0..59).step(5).to_a) }

    def perform
      Event.today.each {|event| Sync::Events::Info.perform_async event.id }
    end

  end
end
