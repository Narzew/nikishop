class Product < ApplicationRecord
  belongs_to :category

  validates :name, uniqueness: true, presence: true
  validates :category, presence: true
end
