# frozen_string_literal: true
module Api
    module V1
      class DoctorsController < ApplicationController
        def all_data
        
          doctor_profiles = DoctorProfile.includes(services: { establishment: :address }, establishments: :address)
          services = Service.includes(:doctor_profile, establishment: :address)
          establishments = Establishment.includes(:address)
        
    
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
                    city: establishment.address&.city, 
                    address: "#{establishment.address&.address_line_1}, #{establishment.address&.address_line_2}"
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
                    city: service.establishment&.address&.city,
                    doctor_name: doctor.name 
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
                city: service.establishment&.address&.city,
                doctor_name: service.doctor_profile.name 
              }
            },
            establishments: establishments.map { |establishment| 
              {
                id: establishment.id,
                name: establishment.name,
                city: establishment.address&.city, 
                address: "#{establishment.address&.address_line_1}, #{establishment.address&.address_line_2}"
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
       
          doctor_profiles = DoctorProfile.includes(services: { establishment: :address }, establishments: :address)
       
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
                  city: establishment.address&.city, 
                  address: "#{establishment.address&.address_line_1}, #{establishment.address&.address_line_2}" 
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
                  city: service.establishment&.address&.city
                }
              }
            }
          }, status: :ok
        end
        def by_city
          city = params[:city]
          
       
          establishments = Establishment.joins(:address)
          .where(addresses: { city: city })
  
        
          doctor_profiles = DoctorProfile.joins(:doctor_establishments)
                                         .where(doctor_establishments: { establishment_id: establishments.pluck(:id) })
  
          
          services = Service.joins(:doctor_profile, :establishment)
                            .where(doctor_profiles: { id: doctor_profiles.pluck(:id) })
                            .where(establishments: { id: establishments.pluck(:id) })

       
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
              city: service.establishment.address.city,
              doctor_name: service.doctor_profile.name 
            }
          end
          render json: {
            doctors: doctor_profiles,
            establishments: establishments.map { |establishment|
            {
              id: establishment.id,
              name: establishment.name,
              city: establishment.address.city,
              address: "#{establishment.address.address_line_1}, #{establishment.address.address_line_2}"
            }
          },
            services: formatted_services
          }
        end
      end
    end
  end
