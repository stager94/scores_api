class Event < ActiveRecord::Base
  belongs_to :status, class_name: EventStatus, foreign_key: :event_status_id
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  belongs_to :competition
  belongs_to :season

  belongs_to :venue
  belongs_to :referee

  has_many :incidents, dependent: :destroy

  after_update :process_webhooks

  PROTOCOL_FIELDS = %w(
    home_yellow_cards_count away_yellow_cards_count
    home_corners_count away_corners_count
  )

  PROTOCOL_FIELDS.each do |param|
    store_accessor :protocol, param
  end

  scope :today, ->{ with_integration.by_date(Date.today) }
  scope :live, ->{ past.in_process }
  scope :only_score, ->{ past.not_started }
  scope :not_started, ->{ with_integration.includes(:status).where(event_statuses: { in_process: false, is_finished: false, is_interrupted: false }) }
  scope :in_process, ->{ with_integration.includes(:status).where(event_statuses: { in_process: true }) }
  scope :past, ->{ with_integration.where "started_at < ?", Time.now }
  scope :with_integration, ->{ where.not external_id: nil }
  scope :without_integration, ->{ where external_id: nil }

  scope :by_datetime, ->(time) { where started_at: time }
  scope :by_date,     ->(date) { where "date(started_at) = ?", date }
  scope :by_teams,    ->(ht_ids, at_ids) { where home_team_id: ht_ids, away_team_id: at_ids }
  scope :by_team,     ->(t_ids) { where "home_team_id = :id OR away_team_id = :id", id: t_ids }

  validates_uniqueness_of :external_id

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

  def process_webhooks
    ScoresApi::WebHooks::Send.new(self).execute if home_score_changed? || away_score_changed? || event_status_id_changed?
  end

end
