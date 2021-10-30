class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :price, :category
end