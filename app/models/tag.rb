class Tag < ApplicationRecord
  enum category: { alcohol_type: 1, origin: 2 }

  validates :category, presence: true
  validates :value, presence: true
end
