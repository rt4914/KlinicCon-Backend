# app/controllers/api/v1/doctor_controller.rb
module Api
    module V1
      class DoctorsController < ApplicationController
        def all_data
          # Fetch all doctor profiles
          doctor_profiles = DoctorProfile.includes(:services, :establishments)
        
          # Fetch all services
          services = Service.includes(:doctor_profile, :establishment)
        
          # Fetch all establishments
          establishments = Establishment.all
        
          # Render the response with structured data
          render json: {
            doctors: doctor_profiles.map { |doctor| 
              {
                id: doctor.id,
                name: doctor.name,
                specialization_id: doctor.specialization_id,
                degree_id: doctor.degree_id,
                institute_id: doctor.institute_id,
                gender: doctor.gender,
                date_of_birth: doctor.date_of_birth,
                year_of_experience: doctor.year_of_experience,
                establishments: doctor.establishments.map { |establishment| 
                  {
                    id: establishment.id,
                    name: establishment.name,
                    city: establishment.city,
                    address: establishment.address
                  }
                },
                services: doctor.services.map { |service| 
                  {
                    id: service.id,
                    name: service.name,
                    day_of_week: service.day_of_week,
                    amount_cents: service.amount_cents,
                    amount_currency: service.amount_currency,
                    start_time: service.start_time,
                    end_time: service.end_time,
                    establishment_id: service.establishment_id,
                    city: service.establishment.city, # Accessing city from the establishment
                    doctor_name: doctor.name # Accessing doctor's name
                  }
                }
              }
            },
            services: services.map { |service| 
              {
                id: service.id,
                name: service.name,
                day_of_week: service.day_of_week,
                amount_cents: service.amount_cents,
                amount_currency: service.amount_currency,
                start_time: service.start_time,
                end_time: service.end_time,
                establishment_id: service.establishment_id,
                city: service.establishment.city,
                doctor_name: service.doctor_profile.name 
              }
            },
            establishments: establishments.map { |establishment| 
              {
                id: establishment.id,
                name: establishment.name,
                city: establishment.city,
                address: establishment.address 
              }
            }
          }, status: :ok
        end        
        def create
            doctor_profile_params = params.require(:doctor_profile).permit(
              :name, :specialization_id, :degree_id, :institute_id, :gender, :date_of_birth,
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
        def index
          # Fetch all doctor profiles and preload related establishments and services
          doctor_profiles = DoctorProfile.includes(:services, :establishments)
  
          # Render the response with nested data
          render json: doctor_profiles.map { |doctor|
            {
              id: doctor.id,
              name: doctor.name,
              specialization_id: doctor.specialization_id,
              degree_id: doctor.degree_id,
              institute_id: doctor.institute_id,
              gender: doctor.gender,
              date_of_birth: doctor.date_of_birth,
              year_of_experience: doctor.year_of_experience,
              establishments: doctor.establishments.map { |establishment|
                {
                  id: establishment.id,
                  name: establishment.name,
                  city: establishment.city,
                  address: establishment.address # Include other fields as necessary
                }
              },
              services: doctor.services.map { |service|
              establishment = service.establishment
                {
                  id: service.id,
                  name: service.name,
                  day_of_week: service.day_of_week,
                  amount_cents: service.amount_cents,
                  amount_currency: service.amount_currency,
                  start_time: service.start_time,
                  end_time: service.end_time,
                  establishment_id: service.establishment_id,
                  city: establishment&.city
                }
              }
            }
          }, status: :ok
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

          # Format the services to include the city from the establishment
          formatted_services = services.map do |service|
            {
              id: service.id,
              name: service.name,
              day_of_week: service.day_of_week,
              amount_cents: service.amount_cents,
              amount_currency: service.amount_currency,
              start_time: service.start_time,
              end_time: service.end_time,
              establishment_id: service.establishment_id,
              city: service.establishment.city,
              doctor_name: service.doctor_profile.name 
            }
          end
          render json: {
            doctors: doctor_profiles,
            establishments: establishments,
            services: formatted_services
          }
        end
      end
    end
  end
