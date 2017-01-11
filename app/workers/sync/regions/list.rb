module Sync
  module Regions
    class List

      include Sidekiq::Worker
      include Sidetiq::Schedulable

      recurrence { weekly }

      def perform
        SofaScore::Football::Regions::Synchronizer.new(lang: "en").run!
      end

    end
  end
end
