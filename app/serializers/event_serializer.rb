class EventSerializer < ActiveModel::Serializer

  attributes :id, :name, :protocol, :home_score, :away_score, :home_scores, :away_scores

  belongs_to :home_team
  belongs_to :away_team
  belongs_to :venue
  belongs_to :referee
  belongs_to :status

end
