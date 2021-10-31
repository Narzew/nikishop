require 'rails_helper'

describe ProductSerializer do
    subject(:serialized_product) { described_class.new(product).to_h }
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }

    it { is_expected.to include(name: product.name) }
    it { is_expected.to include(description: product.description) }
    it { is_expected.to include(price: product.price) }
    it { is_expected.to include(category: Category.find(product.category_id)['name']) }
end