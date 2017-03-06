module Sync
  module Events
    class AllByDate

      include Sidekiq::Worker
      include Sidetiq::Schedulable

      recurrence { daily.hour_of_day([0]) }

      def perform
        [Date.today+1.day, Date.today+4.days, Date.today+7.days].each do |date|
          Region.pluck(:sofa_score_slug).each {|r| Sync::Regions::EventsByDate.perform_async(date, r) }
        end
      end

    end
  end
end
