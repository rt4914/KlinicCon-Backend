class CreateService < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.references :doctor_profile, foreign_key: true
      t.references :establishment, foreign_key: true
      t.string :name, null: false
      t.money :amount, null: false
      t.integer :day_of_week, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :slot_length_in_minutes
      t.timestamps
    end
  end
end
