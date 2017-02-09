class Api::V1::EventsController < ApplicationController

  def find
    events = case params[:type]
    when "by_existing_team"
      find_by_existing_team
    when "by_existing_teams"
      find_by_existing_teams
    else
      find_by_team_names
    end

    if events.count == 1
      render json: events[0]
    else
      render json: { success: false,
                     message: "Found more than one or 0 events by following params",
                     params: params,
                     events: events
                   }
    end
  end

  def show
    event = Event.find params[:id]
    render json: event
  end

  private

  def find_by_existing_teams
    team1 = Team.find(params[:home_team_id]).id
    team2 = Team.find(params[:away_team_id]).id
    date = Time.parse(params[:date]).to_date

    Event.by_teams(team1, team2).by_date(date)
  end

  def find_by_existing_team
    team = Team.find params[:team_id]
    date = Time.parse(params[:date]).to_date

    Event.by_team(team.id).by_date(date)
  end

  def find_by_team_names
    team1 = Team.search_for(params[:home_team]).pluck :id
    team2 = Team.search_for(params[:away_team]).pluck :id
    datetime = Time.parse params[:date]

    Event.by_datetime(datetime).by_teams(team1, team2)
  end

end
