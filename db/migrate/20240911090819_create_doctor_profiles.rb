class CreateDoctorProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_profiles do |t|
      t.string :name
      t.string :gender
      t.datetime :date_of_birth
      t.references :specialization, foreign_key: true
      t.references :degree, foreign_key: true
      t.references :institute, foreign_key: true
      t.integer :year_of_completion
      t.integer :year_of_experience
      t.timestamps
    end
  end
end
