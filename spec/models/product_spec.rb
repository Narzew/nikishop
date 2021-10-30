# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  describe 'relationships' do
    it { is_expected.to belong_to(:category) }
  end

  # == Validations ==========================================================
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_numericality_of(:price) }
  end

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Nested Attributes ====================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
