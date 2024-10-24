# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  def create
    user = User.new(
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )
    user_type = params[:user][:user_type]
    user.create_empty_profile!(user_type)
    user.save
    respond_with user
  end

  private
  def respond_with(resource, _opts = {})
    if request.method == 'POST' && resource.persisted?
      render json: {
        code: 200,
        message: 'Signed up successfully.',
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    elsif request.method == 'DELETE'
      render json: {
        code: 200,
        message: 'Account deleted successfully.'
      }, status: :ok
    else
      render json: {
        message: "User could not be created successfully. #{resource.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end
end
