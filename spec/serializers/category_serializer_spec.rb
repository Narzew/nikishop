require 'rails_helper'

describe CategorySerializer do
    subject(:serialized_category) { described_class.new(category).to_h }
    let(:category) { create(:category) }

    it { is_expected.to include(name: category.name) }
end