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

  describe '.search' do
    let!(:category) { create(:category, name: 'Jedzenie') }
    let!(:first_product) { create(:product, name: 'Mleko', category: category) }
    let!(:second_product) { create(:product, name: 'Pieczywo', category: category) }
    let!(:third_product) { create(:product, name: 'Pieczarki', category: category) }
    let!(:fourth_product) { create(:product, name: 'Pieczone ziemniaki', category: category) }

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

  # == Instance Methods =====================================================
end
