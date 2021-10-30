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

  let!(:category) { create(:category, name: 'Jedzenie') }
  let!(:second_category) { create(:category, name: 'Gotowe dania') }
  let!(:first_product) { create(:product, name: 'Mleko', category: category, price: 4) }
  let!(:second_product) { create(:product, name: 'Pieczywo', category: category, price: 5) }
  let!(:third_product) { create(:product, name: 'Pieczarki', category: category, price: 10) }
  let!(:fourth_product) { create(:product, name: 'Pieczone ziemniaki', category: second_category, price: 12) }

  describe '.search' do
    context 'with .search by name exact' do
      it { expect(described_class.search('Pieczone ziemniaki')).to eq [fourth_product] }
    end

    context 'with .search by name lowercase' do
      it { expect(described_class.search('mleko')).to eq [first_product] }
    end

    context 'with .search by name uppercase' do
      it { expect(described_class.search('PIECZYWO')).to eq [second_product] }
    end

    context 'with .search by name mixed case' do
      it { expect(described_class.search('MlEkO')).to eq [first_product] }
    end

    context 'with .search by name word part' do
      it { expect(described_class.search('piecz').count).to eq 3 }
      it { expect(described_class.search('piecz')).to eq [second_product, third_product, fourth_product] }
    end

    context 'with .search by invalid name' do
      it { expect(described_class.search('mlieko').count).to eq 0 }
      it { expect(described_class.search('mlieko')).to eq [] }
    end

    context 'with .search by too long name' do
      it { expect(described_class.search('mlekoo').count).to eq 0 }
      it { expect(described_class.search('mlekoo')).to eq [] }
    end
  end

  describe '.filter_category' do
    context 'with correct category id' do
      it { expect(described_class.filter_category(category.id).count).to eq 3 }
      it { expect(described_class.filter_category(category.id)).to eq [first_product, second_product, third_product] }
      it { expect(described_class.filter_category(second_category.id).count).to eq 1 }
      it { expect(described_class.filter_category(second_category.id)).to eq [fourth_product] }
    end

    context 'with invalid category id' do
      it { expect(described_class.filter_category(-1).count).to eq 0 }
    end
  end

  describe '.filter_price_exact' do
    it { expect(described_class.filter_price_exact(fourth_product.price)).to eq [fourth_product] }
  end

  describe '.filter_price_greater' do
    it { expect(described_class.filter_price_greater(5)).to eq [third_product, fourth_product] }
  end

  describe '.filter_price_greater_equal' do
    it { expect(described_class.filter_price_greater_equal(5)).to eq [second_product, third_product, fourth_product] }
  end

  describe '.filter_price_lower' do
    it { expect(described_class.filter_price_lower(5)).to eq [first_product] }
  end

  describe '.filter_price_lower_equal' do
    it { expect(described_class.filter_price_lower_equal(5)).to eq [first_product, second_product] }
  end

  # == Instance Methods =====================================================
end
