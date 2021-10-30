# frozen_string_literal: true

class Product < ApplicationRecord
  # == Constants ============================================================
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 5

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :category

  # == Validations ==========================================================
  validates :name, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_blank: false

  # == Scopes ===============================================================
  scope :with_name, ->(name) { where('name ilike ?', "%#{name}%") }

  # == Callbacks ============================================================

  # == Nested Attributes ====================================================

  # == Class Methods ========================================================

  # Pagination
  def self.paged(page:, per_page:)
    page_number = !page.nil? && page.to_i >= 1 ? page.to_i : DEFAULT_PAGE
    per_page_count = !per_page.nil? && per_page.to_i >= 1 ? per_page.to_i : DEFAULT_PER_PAGE
    page(page_number).per(per_page_count)
  end

  # Search course by name
  def self.search(name)
    Product.with_name(name)
  end

  # == Instance Methods =====================================================
end
