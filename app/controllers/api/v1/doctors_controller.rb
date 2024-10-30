# app/controllers/api/v1/doctor_controller.rb
module Api
    module V1
      class DoctorsController < ApplicationController
        def create
            doctor_profile_params = params.require(:doctor_profile).permit(
              :name, :specialization_id, :degree_id, :institute_id, :city, :gender, :date_of_birth,
              establishment_ids: [],
              services_attributes: [:name, :day_of_week, :amount_cents, :establishment_id, :start_time, :end_time]
            )
          
            doctor_profile = DoctorProfile.new(doctor_profile_params)
          
            if doctor_profile.save
              render json: { message: 'Doctor profile created successfully', doctor: doctor_profile }, status: :created
            else
              render json: { errors: doctor_profile.errors.full_messages }, status: :unprocessable_entity
            end
        end
        def by_city
          city = params[:city]
          
          # Fetch all establishments in the specified city
          establishments = Establishment.where(city: city)
  
          # Fetch doctor profiles through DoctorEstablishment join table
          doctor_profiles = DoctorProfile.joins(:doctor_establishments)
                                         .where(doctor_establishments: { establishment_id: establishments.pluck(:id) })
  
          # Fetch services related to doctors and establishments in the specified city
          services = Service.joins(:doctor_profile, :establishment)
                            .where(doctor_profiles: { id: doctor_profiles.pluck(:id) })
                            .where(establishments: { city: city })
  
          render json: {
            doctors: doctor_profiles,
            establishments: establishments,
            services: services
          }
        end
      end
    end
  end
  