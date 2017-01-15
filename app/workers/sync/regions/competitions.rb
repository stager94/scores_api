module Sync
  module Regions
    class Competitions

      include Sidekiq::Worker

      def perform(region_id)
        SofaScore::Football::Competitions::Synchronizer.new(lang: "en", region_id: region_id).run!
      end

    end
  end
end
