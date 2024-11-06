class Review < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :doctor_profile
end