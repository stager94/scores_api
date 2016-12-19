class Team < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_for, against: :title_en, using: :trigram

	translates :title

  belongs_to :stadium
  belongs_to :venue
  belongs_to :referee
  has_many :incidents

  has_attached_file :logo, styles: {
    original: ["150x150>", :png]
  }, default_url: "/images/default/teams/:style.png",
  url: '/teams/logos/:style/:id.:extension'

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
end
