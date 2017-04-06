class CompetitionSerializer < ActiveModel::Serializer

  attributes :id, :title, :logo_url, :source

  def logo_url
    URI.join(ActionController::Base.asset_host, object.flag.url).to_s
  end

  def source
    "sofa_score"
  end

end
