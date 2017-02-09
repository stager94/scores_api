class EventSerializer < ActiveModel::Serializer

  attributes :id, :name, :protocol, :home_score, :away_score, :home_scores, :away_scores, :first_goal

  belongs_to :home_team
  belongs_to :away_team
  belongs_to :venue
  belongs_to :referee
  belongs_to :status

  def first_goal
    return if object.incidents.where(incident_type: "goal").order(time: :asc).count == 0
    object.incidents.where(incident_type: "goal").order(time: :asc)[0].is_home? ? "home" : "away"
  end

end
