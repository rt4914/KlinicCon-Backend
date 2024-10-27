# frozen_string_literal: true
class Appointment < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :service
  enum status: { NOT_CONFIRMED: 0, CONFIRMED: 1, COMPLETED: 2, CANCELLED: 3 }
end
