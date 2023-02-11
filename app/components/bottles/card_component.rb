module Bottles
  class CardComponent < ViewComponent::Base
    def initialize(bottle:)
      @image = bottle.image_url
      @name = bottle.name
      @rating = bottle.expert_rating
      @price = bottle.most_recent_price
      @tags = bottle.tags
    end
  end
end
