module Sync
  module Events
    class Info

      include Sidekiq::Worker

      def perform(event_id)
        ::SofaScore::Football::Events::Incidents.new(event_id).execute
      end

    end
  end
end
