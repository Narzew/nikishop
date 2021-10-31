require 'rails_helper'

describe ProductSerializer do
    subject(:serialized_product) { described_class.new(product).to_h }
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }

    it { is_expected.to include(name: product.name) }
    it { is_expected.to include(description: product.description) }
    it { is_expected.to include(price: product.price) }
    it { is_expected.to include(category: Category.find(product.category_id)['name']) }

    describe 'name' do
        context 'with name blank' do
          let(:product) { build(:product, name: '') }
          it { expect {product.save!}.to  raise_error(ActiveRecord::RecordInvalid) }
        end
    
        context 'with name present' do
            let(:product) { create(:product) }
            it { is_expected.to include(name: product.name) }
        end
    end

    describe 'description' do
        context 'with description blank' do
          let(:product) { create(:product, description: '') }
          it { is_expected.to include(description: ProductSerializer::UNKNOWN_VALUE) }
        end
    
        context 'with description present' do
            let(:product) { create(:product) }
            it { is_expected.to include(description: product.description) }
        end
    end

    describe 'price' do
        context 'with price blank' do
          let(:product) { create(:product, price: -1) }
          it { expect {product.save!}.to  raise_error(ActiveRecord::RecordInvalid) }
        end
    
        context 'with price present' do
            let(:product) { create(:product) }
            it { is_expected.to include(price: product.price) }
        end
    end

    describe 'category' do
        context 'with category blank' do
          let(:product) { create(:product, category: nil) }
          it { expect {product.save!}.to  raise_error(ActiveRecord::RecordInvalid) }
        end
    
        context 'with category present' do
            let(:product) { create(:product) }
            it { is_expected.to include(category: Category.find(product.category_id)['name']) }
        end
    end
      
end