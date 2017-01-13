class Team < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_for, against: :simple_title_en, using: :trigram

	translates :title

  belongs_to :stadium
  belongs_to :venue
  belongs_to :referee
  has_many :incidents

  before_create :set_simple_title
  before_update :set_simple_title

  has_attached_file :logo, styles: {
    original: ["150x150>", :png]
  }, default_url: "/images/default/teams/:style.png",
  url: '/teams/logos/:style/:id.:extension'

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  def set_simple_title
    self[:simple_title_en] = title_en.parameterize
  end
end
