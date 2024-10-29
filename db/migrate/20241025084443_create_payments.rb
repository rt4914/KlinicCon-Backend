class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :amount_cents, null: false  # Store amount in cents for precision
      t.string :amount_currency, default: "USD", null: false  # Currency type
      t.integer :stripe_id, null: false
      t.integer :appointment_id, null: false

      t.timestamps
    end

    # Add foreign key if the appointments table exists and you want this relation
    add_foreign_key :payments, :appointments if table_exists?(:appointments)
    add_index :payments, :appointment_id, unique: true  # To ensure one payment per appointment
  end
end
