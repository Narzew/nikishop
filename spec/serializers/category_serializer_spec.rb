require 'rails_helper'

describe CategorySerializer do
    subject(:serialized_category) { described_class.new(category).to_h }
    let(:category) { create(:category) }

    it { is_expected.to include(name: category.name) }

    describe 'name' do
        context 'with name blank' do
          let(:category) { build(:category, name: '') }
          it { expect {category.save!}.to  raise_error(ActiveRecord::RecordInvalid) }
        end
    
        context 'with name present' do
            let(:category) { create(:category) }
            it { is_expected.to include(name: category.name) }
        end
    end

    describe 'seq' do
        context 'with seq blank' do
          let(:category) { build(:category, seq: nil) }
          it { is_expected.to include(seq: 0) }
        end
    end

end