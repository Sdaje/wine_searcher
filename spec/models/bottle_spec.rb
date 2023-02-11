require 'rails_helper'

RSpec.describe Bottle, type: :model do
  let(:bottle) { create(:bottle) }
  let(:price) { create(:price, bottle:) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(bottle).to be_valid
    end

    %i[name expert_rating].each do |variable|
      it "is not valid without #{variable}" do
        bottle.send("#{variable}=", nil)
        expect(bottle).not_to be_valid
      end
    end

    it 'is not valid with duplicated name' do
      duplicated_bottle = bottle.dup
      expect(duplicated_bottle).not_to be_valid
    end

    it 'is not valid with invalid expert rating' do
      bottle.expert_rating = Faker::Lorem.word
      expect(bottle).not_to be_valid
    end
  end

  describe '#filter_and_order_bottles_with' do
    subject { described_class.filter_and_order_bottles_with(args) }

    context 'search is bottle name' do
      let(:args) { { search: bottle.name } }

      it 'return bottle' do
        expect(subject).to eq([bottle])
      end
    end

    context 'search is random string' do
      let(:args) { { search: Faker::Lorem.word } }

      it 'return empty array' do
        expect(subject).to eq([])
      end
    end

    context 'search is valid max and min prices' do
      let(:min_price) { price.value - 1 }
      let(:max_price) { price.value + 1 }
      let(:args) { { min_price:, max_price: } }

      it 'return bottle' do
        expect(subject).to eq([bottle])
      end
    end

    context 'search is valid min prices' do
      let(:min_price) { price.value - 1 }
      let(:args) { { min_price: } }

      it 'return bottle' do
        expect(subject).to eq([bottle])
      end
    end

    context 'search is superior min prices' do
      let(:min_price) { price.value + 1 }
      let(:args) { { min_price: } }

      it 'return empty array' do
        expect(subject).to eq([])
      end
    end
  end
end
