class Price < ApplicationRecord
  belongs_to :bottle

  validates :value, presence: true, numericality: true
  validates :website, presence: true
end
