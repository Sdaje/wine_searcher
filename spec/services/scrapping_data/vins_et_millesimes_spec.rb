require 'rails_helper'

RSpec.describe ScrappingData::VinsEtMillesimes do
  describe '#call' do
    subject { described_class.new.call }

    it 'return a hash with the right keys' do
      expect(subject.sample.keys).to eq(%i[bottle price tags])
    end

    it 'bottle composition is correct' do
      expect(subject.sample[:bottle].keys).to eq(%i[name image_url expert_rating])
    end

    it 'price composition is correct' do
      expect(subject.sample[:price].keys).to eq(%i[value website])
    end

    it 'tags composition is correct' do
      expect(subject.sample[:tags].keys).to eq(%i[alcohol_type origin])
    end
  end
end
