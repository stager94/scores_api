class Competition < ActiveRecord::Base

  include PgSearch
  pg_search_scope :search_for, against: :title_en, using: :trigram

	translates :title

  belongs_to :region, counter_cache: true
  has_one :sport, through: :region
  has_many :seasons

  counter_culture [:region, :sport]

  has_attached_file :flag, styles: { original: ["150x150>", :png]}, default_url: "/images/default/competitions/:style.png"
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\z/

  after_create :sync_events

  def import_sofa_score_flag!
  	SofaScore::Football::Competitions::ImportFlag.new(competition_id: self.id).run!
  end

  def sync_events
    Sync::Competitions::Events.perform_async self.id
  end

end
