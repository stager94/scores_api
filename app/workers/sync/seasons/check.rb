module Sync
  module Seasons
    class Check

      include Sidekiq::Worker
      include Sidetiq::Schedulable

      recurrence { daily.hour_of_day(6) }

      def perform
        Season.where(is_active: true).where("end_date <= ?", Date.today).pluck(:competition_id).each do |cid|
          SofaScore::Football::Seasons::Synchronizer.new(cid).execute
        end
      end

    end
  end
end
