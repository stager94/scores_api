class Season < ActiveRecord::Base
  belongs_to :competition
  has_many :events

  scope :active, -> { where(is_active: true).first }

end
