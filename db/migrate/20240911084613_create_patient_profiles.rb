class CreatePatientProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :patient_profiles do |t|
      t.string :name
      t.string :gender
      t.datetime :date_of_birth
      t.string :blood_group
      t.references :address, foreign_key: true
      t.timestamps
    end
  end
end
