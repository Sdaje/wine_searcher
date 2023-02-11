class BottlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @bottles = Bottle.all.order(expert_rating: :desc)
  end
end
