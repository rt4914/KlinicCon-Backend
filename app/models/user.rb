class User < ApplicationRecord
  belongs_to :patient_profile, optional: true
  belongs_to :doctor_profile, optional: true

  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :pwned_password,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
