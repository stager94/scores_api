module Sync
  module Events
    class Daily

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { hourly(2) }

      def perform
        (Date.today..Date.today+2.days).each do |date|
          SofaScore::Football::Events::ByDate.new(date: date).execute
        end
      end

    end
  end
end
