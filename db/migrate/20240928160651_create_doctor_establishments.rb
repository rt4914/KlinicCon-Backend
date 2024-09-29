class CreateDoctorEstablishments < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_establishments do |t|
      t.references :doctor_profile, null: false, foreign_key: true
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
