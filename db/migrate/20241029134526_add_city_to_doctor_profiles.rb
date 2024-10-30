class AddCityToDoctorProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :doctor_profiles, :city, :string
  end
end
