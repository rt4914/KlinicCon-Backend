module Api
  module V1
    class CitiesController < ApplicationController
      
      def index
        cities = Establishment.select(:city).distinct.where.not(city: nil).pluck(:city)
        render json: cities.map { |city| { city_name: city } }
      end

    end
  end
end