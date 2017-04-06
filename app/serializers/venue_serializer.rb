class VenueSerializer < ActiveModel::Serializer

  attributes :id, :country, :city, :stadium_name, :stadium_capacity, :source

  def source
    "sofa_score"
  end

end
