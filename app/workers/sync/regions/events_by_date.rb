module Sync
  module Regions
    class EventsByDate

      include Sidekiq::Worker

      def perform(date, region_slug)
        SofaScore::Football::Events::AllByDate.new(date: date, region_slug: region_slug).execute
      end

    end
  end
end
