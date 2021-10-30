class Product < ApplicationRecord
  # == Constants ============================================================
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 24

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :category

  # == Validations ==========================================================
  validates :name, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, numericality: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Nested Attributes ====================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
