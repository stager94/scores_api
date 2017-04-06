class TeamSerializer < ActiveModel::Serializer
  attributes :title_en, :title_ru, :title_de,
             :full_title_en, :full_title_ru, :full_title_de,
             :logo_url, :id, :sofascore_url, :sofa_score_id

  def logo_url
    URI.join(ActionController::Base.asset_host, object.logo.url).to_s
  end

  def sofascore_url
    "test"
  end

end
