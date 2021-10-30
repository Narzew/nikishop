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

  def self.paged(page:, per_page:)
    page_number = !page.nil? && page.to_i >= 1 ? page.to_i : DEFAULT_PAGE
    per_page_count = !per_page.nil? && per_page.to_i >= 1 ? per_page.to_i : DEFAULT_PER_PAGE
    page(page_number).per(per_page_count)
  end

  # == Instance Methods =====================================================
end
