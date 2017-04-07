module Sync
  module Competitions
    class List

      include Sidekiq::Worker
      # include Sidetiq::Schedulable

      # recurrence { daily }

      def perform
        Region.all.each do |region|
          Sync::Regions::Competitions.perform_async(region.id)
        end
      end

    end
  end
end
