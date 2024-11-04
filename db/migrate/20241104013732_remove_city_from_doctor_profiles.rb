class RemoveCityFromDoctorProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :doctor_profiles, :city, :string
  end
end
