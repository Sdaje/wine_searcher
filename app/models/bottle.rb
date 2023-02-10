class Bottle < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :expert_rating, presence: true, numericality: { only_integer: true, in: (1..100) }
end
