require 'rails_helper'

RSpec.describe Price, type: :model do
  let(:bottle) { create(:bottle) }
  let(:price) { create(:price, bottle:) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(price).to be_valid
    end

    %i[value website bottle].each do |variable|
      it "is not valid without #{variable}" do
        price.send("#{variable}=", nil)
        expect(price).not_to be_valid
      end
    end

    it 'is not valid with invalid value' do
      price.value = Faker::Lorem.word
      expect(price).not_to be_valid
    end
  end
end
