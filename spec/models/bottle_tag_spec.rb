require 'rails_helper'

RSpec.describe BottleTag, type: :model do
  let(:bottle) { create(:bottle) }
  let(:tag) { create(:tag) }
  let(:bottle_tag) { BottleTag.new(bottle:, tag:) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(bottle_tag).to be_valid
    end

    %i[bottle tag].each do |variable|
      it "is not valid without #{variable}" do
        bottle_tag.send("#{variable}=", nil)
        expect(bottle_tag).not_to be_valid
      end
    end
  end
end
