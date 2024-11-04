# TODO: Remove optional: true once appointment model is added
class Payment < ApplicationRecord
    # Associations
    belongs_to :appointment, optional: true
  
    # Money-rails setup
    monetize :amount_cents, with_model_currency: :amount_currency

    # Validations
    validates :amount_cents, presence: true, numericality: { greater_than: 0 }
    validates :stripe_id, presence: true, uniqueness: true
    validates :appointment_id, presence: true, uniqueness: true  
  end
