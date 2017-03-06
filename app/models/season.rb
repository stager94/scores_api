class Season < ActiveRecord::Base
  belongs_to :competition
  has_many :events

  scope :active, -> { where(is_active: true).first }
  validates_uniqueness_of :external_id

end
