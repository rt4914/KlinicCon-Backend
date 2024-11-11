class Establishment < ApplicationRecord
  belongs_to :address
  has_many :doctor_establishments, dependent: :destroy
  has_many :doctor_profiles, through: :doctor_establishments

  validates :name, presence: true

  accepts_nested_attributes_for :address, update_only: true
end
