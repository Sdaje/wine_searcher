require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(tag).to be_valid
    end

    %i[category value].each do |variable|
      it "is not valid without #{variable}" do
        tag.send("#{variable}=", nil)
        expect(tag).not_to be_valid
      end
    end
  end
end
