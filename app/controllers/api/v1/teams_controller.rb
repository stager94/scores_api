class Api::V1::TeamsController < Api::V1::BaseController

  def find
    teams = Team.search_for params[:title]
    if teams.any?
      render json: {
        count: teams.length,
        resources: ActiveModel::Serializer::ArraySerializer.new(teams, each_serializer: TeamSerializer)
      }, status: 200
    else
      render json: { error: true }, status: 404
    end
  end

  def show
    team = Team.find params[:id]
    render json: team
  end

end
