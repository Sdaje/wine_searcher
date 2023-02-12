require 'rails_helper'

RSpec.describe DataBuilder do
  let(:source_data) do
    [{
      bottle: { name: Faker::Beer.name,
                expert_rating: Faker::Number.number(digits: 2),
                image_url: Faker::Internet.url },
      price: { value: Faker::Number.number(digits: 3), website: Faker::Internet.url },
      tags: { alcohol_type: 'beer' }
    }]
  end

  describe '#run' do
    subject { described_class.new(source_data).run }

    context 'Instances are valid' do
      %w[Bottle Price Tag BottleTag].each do |klass|
        it "save #{klass}" do
          expect { subject }.to change { klass.constantize.count }.by(1)
        end
      end
    end

    context 'Bottle and tag exist' do
      let(:bottle) { create(:bottle) }
      let(:tag) { create(:tag) }

      [['Bottle', 0], ['Tag', 0], ['Price', 1]].each do |klass, count_change|
        it "#{count_change.zero? ? 'does not' : ''} save #{klass}" do
          source_data.first[:bottle][:name] = bottle.name
          source_data.first[:tags] = { tag.category => tag.value }
          expect { subject }.to change { klass.constantize.count }.by(count_change)
        end
      end
    end
  end
end
