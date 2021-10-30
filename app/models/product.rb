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
  scope :with_category_id, ->(category_id) { where('category_id = ?', category_id) }
  scope :with_price_lower_than, ->(price) { where('price < ?', price) }
  scope :with_price_greater_than, ->(price) { where('price > ?', price) }
  scope :with_price_lower_equal_than, ->(price) { where('price <= ?', price) }
  scope :with_price_greater_equal_than, ->(price) { where('price >= ?', price) }
  scope :with_price_equal, ->(price) { where('price = ?', price) }

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

  # Filter by category
  def self.filter_category(category_id)
    Product.with_category_id(category_id)
  end

  def self.filter_price_lower(price)
    Product.with_price_lower_than(price)
  end

  def self.filter_price_greater(price)
    Product.with_price_greater_than(price)
  end

  def self.filter_price_lower_equal(price)
    Product.with_price_lower_equal_than(price)
  end

  def self.filter_price_greater_equal(price)
    Product.with_price_greater_equal_than(price)
  end

  def self.filter_price_exact(price)
    Product.with_price_equal(price)
  end

  # == Instance Methods =====================================================
end
