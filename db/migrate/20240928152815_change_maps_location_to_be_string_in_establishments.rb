class ChangeMapsLocationToBeStringInEstablishments < ActiveRecord::Migration[7.1]
  def change
    change_column :establishments, :maps_location, :string
  end
end
