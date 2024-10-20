class CreateAppointment < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :patient_profile, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.datetime :slot_start_time
      t.datetime :slot_end_time
      t.integer :status
      t.timestamps
    end
  end
end
