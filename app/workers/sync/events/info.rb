module Sync
  module Events
    class Info

      include Sidekiq::Worker

      sidekiq_options retry: true, unique: :until_and_while_executing

      def perform(event_id)
        ::SofaScore::Football::Events::Incidents.new(event_id).execute
      end

    end
  end
end
