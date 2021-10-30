# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :seq
  UNKNOWN_VALUE = ''

  def name
    return UNKNOWN_VALUE unless object.name

    object.name
  end

  def seq
    return 0 unless object.seq
  end
end
