class Service < ApplicationRecord
  belongs_to :doctor_profile
  belongs_to :establishment
  enum day_of_week: { Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5, Sunday: 6 }
  monetize :amount_cents

 
  def city_name
    establishment&.city
  end


  scope :by_city, ->(city_name) { joins(:establishment).where(establishments: { city: city_name }) }

  validates :name, presence: true
  validates :day_of_week, presence: true
  validates :amount_cents, presence: true
  validates :establishment_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
