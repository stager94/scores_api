class Api::V1::CompetitionsController < ApplicationController

  def find
    region = Region.search_for(params[:region]).first
    competition = region.competitions.search_for(params[:competition]).first

    render json: competition
  end

end
