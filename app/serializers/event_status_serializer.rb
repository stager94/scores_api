class EventStatusSerializer < ActiveModel::Serializer

  attributes :id, :code, :description, :type, :key,
             :is_finished, :in_process, :is_interrupted

end
