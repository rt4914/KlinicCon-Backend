class PatientProfile < ApplicationRecord
  belongs_to :address, optional: true
  has_one :user
end
