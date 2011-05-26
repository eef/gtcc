class GarageController < ApplicationController
  def index
    @owned_cars = current_user.owned_cars
  end

end
