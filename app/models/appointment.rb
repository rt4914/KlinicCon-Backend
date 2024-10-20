# frozen_string_literal: true
class Appointment < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :service
  enum status: { NOT_CONFIRMED: 0, CONFIRMED: 1, CANCELLED: 2, COMPLETED: 3 }
end

