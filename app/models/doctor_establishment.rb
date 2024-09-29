class DoctorEstablishment < ApplicationRecord
  belongs_to :doctor_id
  belongs_to :establishment_id
end
