class BottlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @bottles = Bottle.filter_and_order_bottles_with(params)

    respond_to do |format|
      format.html
      format.text { render partial: "bottles/list", locals: { bottles: @bottles }, formats: [:html] }
    end
  end
end
