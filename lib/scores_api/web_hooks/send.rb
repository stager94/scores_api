module ScoresApi
  module WebHooks
    class Send

      attr_accessor :event

      def initialize(event)
        @event = event
      end

      def execute
        WebHook.all.each {|webhook| Net::HTTP.post_form(URI.parse(webhook.url), info) }
      end

      private

      def info
        EventSerializer.new(event).as_json
      end

    end
  end
end
