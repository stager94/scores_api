module Sync
  module Competitions
    class List

      include Sidekiq::Worker
      include Sidetiq::Schedulable

      recurrence { weekly }

      def perform
        Region.all.each do |region|
          SofaScore::Football::Competitions::Synchronizer.new(lang: "en", region_id: region.id).run!
        end
      end

    end
  end
end
