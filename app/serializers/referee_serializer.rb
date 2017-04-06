class RefereeSerializer < ActiveModel::Serializer

  attributes :id, :name, :country, :source

  def source
    "sofa_score"
  end

end
