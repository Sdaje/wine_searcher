class Tag < ApplicationRecord
  has_many :bottle_tags, dependent: :destroy
  has_many :bottles, through: :bottle_tags

  enum category: { alcohol_type: 1, origin: 2 }

  validates :category, presence: true
  validates :value, presence: true
end
