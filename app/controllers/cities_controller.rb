class CitiesController < ApplicationController
  def index
    cities = Address.select(:city).distinct.pluck(:city)
    render json: cities
  
  end
end
