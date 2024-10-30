# app/controllers/api/v1/establishments_controller.rb
module Api
    module V1
      class EstablishmentsController < ApplicationController
        def index
          establishments = Establishment.all
          render json: establishments, status: :ok
        end
      end
    end
  end
  