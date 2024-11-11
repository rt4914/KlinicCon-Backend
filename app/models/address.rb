class Address < ApplicationRecord
  validates :address_line_1, :city, :state, :country, :pin_code, presence: true
end
