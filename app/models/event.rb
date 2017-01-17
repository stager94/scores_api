class Event < ActiveRecord::Base
  belongs_to :status, class_name: EventStatus, foreign_key: :event_status_id
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  belongs_to :competition
  belongs_to :season

  belongs_to :venue
  belongs_to :referee

  has_many :incidents, dependent: :destroy

  scope :today, ->{ by_date(Date.today) }
  scope :live, ->{ past.in_process }
  scope :only_score, ->{ past.not_started }
  scope :not_started, ->{ includes(:status).where(event_statuses: { in_process: false, is_finished: false, is_interrupted: false }) }
  scope :in_process, ->{ includes(:status).where(event_statuses: { in_process: true }) }
  scope :past, ->{ where "started_at < ?", Time.now }

  scope :by_datetime, ->(time) { where started_at: time }
  scope :by_date,     ->(date) { where "date(started_at) = ?", date }
  scope :by_teams,    ->(ht_ids, at_ids) { where home_team_id: ht_ids, away_team_id: at_ids }
  scope :by_team,     ->(t_ids) { where "home_team_id = :id OR away_team_id = :id", id: t_ids }

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
