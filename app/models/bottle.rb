class Bottle < ApplicationRecord
  include PgSearch::Model

  # Relations
  has_many :prices, dependent: :destroy
  has_many :bottle_tags, dependent: :destroy
  has_many :tags, through: :bottle_tags

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :expert_rating, presence: true, numericality: { only_integer: true, in: (1..100) }

  # PG Search
  pg_search_scope :search_by_name_and_tags,
                  against: :name,
                  associated_against: { tags: :value },
                  using: { tsearch: { prefix: true } }

  # Class
  class << self
    def filter_and_order_bottles_with(args = {})
      bottles = define_bottles(args[:search])
      return bottles if args[:min_price].nil? && args[:max_price].nil?

      filter_bottles_by_prices(bottles, args[:min_price].to_f, args[:max_price].to_f)
    end

    private

    def define_bottles(search)
      search.present? ? search_bottles_ordered_by_ratings(search) : all_bottles_ordered_by_ratings
    end

    def search_bottles_ordered_by_ratings(search)
      search_by_name_and_tags(search).order(expert_rating: :desc)
    end

    def all_bottles_ordered_by_ratings
      all.order(expert_rating: :desc)
    end

    def filter_bottles_by_prices(bottles, min_price, max_price)
      bottles.select { |bottle| bottle.between_prices?(min_price, max_price) }
    end
  end

  # Instances
  def between_prices?(min_price, max_price)
    max_price.zero? ? price_superior_to?(min_price) : price_between?(min_price, max_price)
  end

  def most_recent_price
    prices.order(created_at: :desc).first.value
  end

  private

  def price_superior_to?(value)
    most_recent_price >= value
  end

  def price_between?(min_value, max_value)
    most_recent_price >= min_value && most_recent_price <= max_value
  end
end
