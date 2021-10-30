# frozen_string_literal: true

class Category < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  has_many :products

  # == Validations ==========================================================
  validates :name, uniqueness: true, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_blank: false

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Nested Attributes ====================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
