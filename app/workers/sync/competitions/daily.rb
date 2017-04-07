module Sync
  module Competitions
    class Daily

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { daily }

      def perform
        (Date.today..Date.today+2.weeks).each do |date|
          SofaScore::Football::Competitions::ByDate.new(date: date).execute
        end
      end

    end
  end
end
