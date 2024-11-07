class Review < ApplicationRecord
  belongs_to :patient_profile
  belongs_to :doctor_profile

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 500 }, allow_blank: true
end
