class PatientProfile < ApplicationRecord
  belongs_to :address
  has_one :user
end
