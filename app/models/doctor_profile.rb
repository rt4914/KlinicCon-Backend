class DoctorProfile < ApplicationRecord
  belongs_to :specialization, optional: true
  belongs_to :degree, optional: true
  belongs_to :institute, optional: true
  has_one :user
end