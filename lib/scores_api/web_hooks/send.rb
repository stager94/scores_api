module ScoresApi
  module WebHooks
    class Send

      attr_accessor :event

      def initialize(event)
        @event = event
      end

      def execute
        WebHook::Resource.all.each {|webhook| process_to webhook }
      end

      private

      def info
        EventSerializer.new(event).to_json
      end

      def process_to(resource)
        uri = URI resource.url
        http = Net::HTTP.new uri.host, uri.port
        req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        req.body = info
        res = http.request req

        resource.logs.create status: res.code.to_i, params: info, response: res.body
      end

    end
  end
end
