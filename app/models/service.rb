class Service < ApplicationRecord
  belongs_to :doctor_profile
  belongs_to :establishment
  enum day_of_week: {Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5, Sunday: 6 }
end

