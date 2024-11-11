class Api::V1::EstablishmentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_doctor_profile, only: %i[create update destroy]
  before_action :set_establishment, only: %i[update destroy]

  def index
    establishments = filter_establishments
    if establishments.exists?
      render_success('Establishments found successfully.', establishments)
    else
      render_error('No establishments match the given criteria.', :not_found)
    end
  end

  def show
    establishment = Establishment.find_by(id: params[:id])
    if establishment
      render_success('Establishment found successfully.', establishment)
    else
      render_error('Establishment not found.', :not_found)
    end
  end

  def create
    establishment = @doctor_profile.establishments.create(establishment_params)
    if establishment.persisted?
      render_success('Establishment created successfully.', establishment)
    else
      render_error("Establishment could not be created. #{establishment.errors.full_messages.to_sentence}")
    end
  end

  def update
    if @establishment.update(establishment_params)
      render_success('Establishment updated successfully.', @establishment)
    else
      render_error("Establishment could not be updated. #{@establishment.errors.full_messages.to_sentence}")
    end
  end

  def destroy
    @establishment.destroy
    render_success('Establishment deleted successfully.')
  end

  private

  def establishment_params
    params.require(:establishment).permit(:name, :latitude, :longitude, :maps_location, address_attributes: [:address_line_1, :address_line_2, :city, :state, :country, :pin_code])
  end

  def set_doctor_profile
    @doctor_profile = current_user&.doctor_profile
    return render_error('User is not authorized.', :forbidden) unless @doctor_profile
  end

  def set_establishment
    @establishment = @doctor_profile.establishments.find_by(id: params[:id])
    render_error('Establishment not found.', :not_found) unless @establishment
  end

  def filter_establishments
    filter_params = params.permit(:name, :city, :state, :country, :pin_code, :doctor_profile_id)

    scope = Establishment.all
    scope = scope.joins(:address) if address_filter_params_present?(filter_params)
    scope = scope.joins(:doctor_profiles) if filter_params[:doctor_profile_id].present?

    scope = scope.where(name: filter_params[:name]) if filter_params[:name].present?
    scope = scope.where(addresses: { city: filter_params[:city], state: filter_params[:state], country: filter_params[:country], pin_code: filter_params[:pin_code] }.compact) if address_filter_params_present?(filter_params)
    scope = scope.where(doctor_profiles: { id: filter_params[:doctor_profile_id] }) if filter_params[:doctor_profile_id].present?

    scope
  end

  def address_filter_params_present?(filter_params)
    filter_params[:city].present? || filter_params[:state].present? || filter_params[:country].present? || filter_params[:pin_code].present?
  end

  def render_success(message, data = nil)
    render json: { message: message, data: data }.compact, status: :ok
  end

  def render_error(message, status = :unprocessable_entity)
    render json: { message: message }, status: status
  end
end
