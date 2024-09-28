class CreateEstablishments < ActiveRecord::Migration[7.1]
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.references :address, null: false, foreign_key: true
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.decimal :maps_location, precision: 10, scale: 6

      t.timestamps
    end
  end
end
