# SofaScore::Football::Events::Incidents.new(7242763).execute

module SofaScore
  module Football
    module Events
      class Incidents

        attr_reader :event_id

        def initialize(event_id)
          @event_id = event_id
        end

        def execute
          failed and return if json["error"].present?
          json["incidents"].each {|incident_params| process_incident_with incident_params }
          ::SofaScore::Football::Events::ExtendedInfo.new(event_id, json["event"]).execute
        end

        private

        def url
          "http://www.sofascore.com/event/#{event.external_id}/json"
        end

        def event
          @_event ||= Event.find event_id
        end

        def uri
          URI.parse url
        end

        def http
          Net::HTTP.get_response uri
        end

        def body
          http.body
        end

        def json
          @_json ||= JSON.parse body
        end

        def process_incident_with(params)
          SofaScore::Football::Incidents::Saver.new(event_id, params).execute
        end

        def failed
          event.update external_id: nil
        end

      end
    end
  end
end
