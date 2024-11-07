# frozen_string_literal: true
class DoctorEstablishment < ApplicationRecord
  belongs_to :doctor_profile
  belongs_to :establishment
end
