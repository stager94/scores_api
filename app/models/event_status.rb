class EventStatus < ActiveRecord::Base
  self.inheritance_column = nil

  TYPE_MAPPING = {
    inprogress: {
      is_finished: false,
      is_interrupted: false,
      in_process: true
    },
    delayed: {
      is_finished: false,
      is_interrupted: false,
      in_process: false
    },
    interrupted: {
      is_finished: false,
      is_interrupted: true,
      in_process: false
    },
    canceled: {
      is_finished: true,
      is_interrupted: true,
      in_process: false
    },
    postponed: {
      is_finished: true,
      is_interrupted: true,
      in_process: false
    },
    notstarted: {
      is_finished: false,
      is_interrupted: false,
      in_process: false
    },
    finished: {
      is_finished: true,
      is_interrupted: false,
      in_process: false
    }
  }

  after_create :set_type

  def set_type
    update TYPE_MAPPING[self.type.to_sym]
  end
end
