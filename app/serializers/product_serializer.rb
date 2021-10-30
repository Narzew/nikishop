# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :category
  UNKNOWN_VALUE = ''

  def name
    return UNKNOWN_VALUE unless object.name

    object.name
  end

  def description
    return UNKNOWN_VALUE unless object.description

    object.description
  end

  def price
    return UNKNOWN_VALUE unless object.price

    object.price
  end

  def category
    return UNKNOWN_VALUE unless object.category.name

    object.category.name
  end
end
