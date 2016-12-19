module SofaScore
  module Football
    module Incidents
      class Saver

        attr_reader :params, :event_id

        def initialize(event_id, params)
          @event_id = event_id
          @params = params
        end

        def execute
          return if !external_id.present? || incident.present?
          Incident.create new_incident_params
        end

        private

        def event
          @_event ||= Event.find event_id
        end

        def external_id
          params["id"]
        end

        def incident
          Incident.find_by_external_id external_id
        end

        def new_incident_params
          {
            external_id: external_id,
            player_id: player.id,
            is_home: params["isHome"],
            time: params["time"] || 0,
            added_time: params["addedTime"] || 0,
            incident_type: params["incidentType"],
            incident_class: params["incidentClass"],
            description: params["description"],
            params: {},
            extended_params: params,
            event_id: event_id,
            team_id: team.id
          }
        end

        def player
          return Player.new unless params["player"].present?
          @_player ||= (find_player || create_player)
        end

        def find_player
          Player.find_by_external_id params["player"]["id"]
        end

        def create_player
          Player.create external_id: params["player"]["id"],
                        name: params["player"]["name"],
                        slug: params["player"]["slug"],
                        short_name: params["player"]["shortName"]
        end

        def team
          params["isHome"] ? event.home_team : event.away_team
        end

      end
    end
  end
end
