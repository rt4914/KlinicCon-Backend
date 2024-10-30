# app/controllers/api/v1/services_controller.rb
module Api
    module V1
      class ServicesController < ApplicationController
        def index
          services = Service.all
          render json: services, status: :ok
        end
      end
    end
  end
  