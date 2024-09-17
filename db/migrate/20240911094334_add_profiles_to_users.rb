class AddProfilesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :patient_profile, foreign_key: true
    add_reference :users, :doctor_profile, foreign_key: true
  end
end
