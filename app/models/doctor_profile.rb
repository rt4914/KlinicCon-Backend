class DoctorProfile < ApplicationRecord
  belongs_to :specialization
  belongs_to :degree
  belongs_to :institute
  has_one :user
end

