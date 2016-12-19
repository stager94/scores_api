class Event < ActiveRecord::Base
  belongs_to :status, class_name: EventStatus, foreign_key: :event_status_id
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  belongs_to :competition
  belongs_to :season

  has_many :incidents, dependent: :destroy

  # scope :live, -> { includes(:status).where("started_at > ? AND statuses.type NOT IN ('finished', '')", Time.now) }
  scope :today, ->{ where('date(started_at) = ?', Date.today) }

  def first_half_home_score
    home_scores["period1"].to_i
  end

  def first_half_away_score
    away_scores["period1"].to_i
  end

  def draw_full_score
    return "-:-" unless status.is_finished?
    "#{home_score}:#{away_score} (#{first_half_home_score}:#{first_half_away_score})"
  end

end
