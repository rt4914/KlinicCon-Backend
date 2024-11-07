# frozen_string_literal: true
module Api
    module V1
      class EstablishmentsController < ApplicationController
        def index
          establishments = Establishment.includes(:address).all
          render json: establishments.as_json(include: :address), status: :ok
        end
  
        def by_city
          city = params[:city]
          establishments = Establishment.joins(:address).where(addresses: { city: city })
          render json: establishments.as_json(include: :address), status: :ok
        end        
      end
    end
  end
