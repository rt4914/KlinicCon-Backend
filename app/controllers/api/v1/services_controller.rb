# app/controllers/api/v1/services_controller.rb
module Api
    module V1
      class ServicesController < ApplicationController
        def index
          services = Service.includes(:establishment).all

          render json: services.as_json(
            only: [:id, :doctor_profile_id, :name, :day_of_week, :start_time, :end_time, :slot_length_in_minutes, :amount_cents, :amount_currency],
            methods: :city_name
          ), status: :ok
        end
        def by_city
          city = params[:city]
          services = Service.includes(:establishment).by_city(city)
  
          render json: services.as_json(include: { establishment: { only: :city } })
        end
      end
    end
  end
