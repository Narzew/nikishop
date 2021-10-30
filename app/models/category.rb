class Category < ApplicationRecord
    has_many :products
    validates :name, uniqueness: true, presence: true
    validates :price, numericality: { greater_than: 0 }, allow_blank: false
end
