class EventStatus < ActiveRecord::Base
  self.inheritance_column = nil

  ENDING_STATUSES = %w(finished canceled)

  def is_finished?
    ENDING_STATUSES.include? type
  end
end
