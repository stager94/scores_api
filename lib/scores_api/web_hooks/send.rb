module ScoresApi
  module WebHooks
    class Send

      attr_accessor :event

      def initialize(event)
        @event = event
      end

      def execute
        WebHook.all.each {|webhook| process_to webhook }
      end

      private

      def info
        EventSerializer.new event
      end

      def process_to(webhook)
        uri = URI webhook.url
        http = Net::HTTP.new uri.host, uri.port
        req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        req.body = info.to_json
        http.request req
      end

    end
  end
end
