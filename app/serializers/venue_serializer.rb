class VenueSerializer < ActiveModel::Serializer

  attributes :id, :country, :city, :stadium_name, :stadium_capacity

end
