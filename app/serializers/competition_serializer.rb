class CompetitionSerializer < ActiveModel::Serializer

  attributes :id, :title, :logo_url

  def logo_url
    URI.join(ActionController::Base.asset_host, object.flag.url).to_s
  end

end
