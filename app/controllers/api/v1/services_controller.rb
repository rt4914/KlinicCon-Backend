# frozen_string_literal: true
module Api
    module V1
      class ServicesController < ApplicationController
        def index
          services = Service.includes(establishment: :address).all
        
          render json: services.as_json(
            only: [:id, :doctor_profile_id, :name, :day_of_week, :start_time, :end_time, :slot_length_in_minutes, :amount_cents, :amount_currency],
            methods: :city_name
          ), status: :ok
        end
        def by_city
          city = params[:city]
          services = Service.by_city(city)
        
          render json: services.as_json(
            include: {
              establishment: {
                include: { address: { only: :city } },
                only: [:id, :name]
              }
            },
            only: [:id, :name, :doctor_profile_id, :day_of_week, :start_time, :end_time, :amount_cents, :amount_currency]
          ), status: :ok
        end
        
      end
    end
  end
