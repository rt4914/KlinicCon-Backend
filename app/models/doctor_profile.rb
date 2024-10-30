class DoctorProfile < ApplicationRecord
  belongs_to :specialization, optional: true
  belongs_to :degree, optional: true
  belongs_to :institute, optional: true
  has_one :user

  # Association for the join table
  has_many :doctor_establishments
  has_many :establishments, through: :doctor_establishments

   # Define the association with Service
  has_many :services
  accepts_nested_attributes_for :services
end