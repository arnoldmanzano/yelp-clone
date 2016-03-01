class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

end
