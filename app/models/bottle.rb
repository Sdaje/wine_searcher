class Bottle < ApplicationRecord
  has_many :prices, dependent: :destroy
  has_many :bottle_tags, dependent: :destroy
  has_many :tags, through: :bottle_tags

  validates :name, presence: true, uniqueness: true
  validates :expert_rating, presence: true, numericality: { only_integer: true, in: (1..100) }
end
