class Payment < ApplicationRecord
    # Associations
    belongs_to :appointment, optional: true
  
    # Validations
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :stripe_id, presence: true, uniqueness: true
    validates :appointment_id, presence: true, uniqueness: true  
  end
  
