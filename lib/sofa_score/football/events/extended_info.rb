module SofaScore
  module Football
    module Events
      class ExtendedInfo < SofaScore::Football::Events::Base

        attr_reader :event_id, :params

        def initialize(event_id, params)
          @event_id = event_id
          @params   = params
        end

        def execute
          update_season if event.season.slug.nil?
          event.update venue_id: venue.try(:id) if event.venue_id.nil?
          event.update referee_id: referee.try(:id) if event.referee_id.nil?
          update_event
        end

        private

        def event
          @_event ||= Event.find event_id
        end

        def update_season
          return unless params[:season]
          event.season.update name: params["season"]["name"],
                              slug: params["season"]["slug"]
        end

        def venue
          return unless params["venue"]
          v = Venue.where(external_id: params["venue"]["id"]).first_or_initialize
          if v.new_record?
            v.update country: params["venue"]["country"]["name"],
                     city: params["venue"]["city"]["name"],
                     stadium_name: params["venue"]["stadium"]["name"],
                     stadium_capacity: params["venue"]["stadium"]["capacity"]
          end
          return v
        end

        def referee
          return unless params["referee"]
          r = Referee.where(external_id: params["referee"]["id"]).first_or_initialize
          if r.new_record?
            r.update name: params["referee"]["name"],
                     country: params["referee"]["country"]["name"]
          end
          return r
        end

        def update_event
          event.update event_status_id: (find_status || create_status).id,
                       home_score: (params["homeScore"]["current"] rescue 0),
                       away_score: (params["awayScore"]["current"] rescue 0),
                       home_scores: params["homeScore"].is_a?(Array) ? {} : params["homeScore"],
                       away_scores: params["awayScore"].is_a?(Array) ? {} : params["awayScore"],
                       started_at: Time.at(params["startTimestamp"])
        end

      end
    end
  end
end
