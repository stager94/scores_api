class EventSerializer < ActiveModel::Serializer

  attributes :id, :name

  belongs_to :home_team
  belongs_to :away_team
  belongs_to :venue
  belongs_to :referee

end
