class AddCityToEstablishments < ActiveRecord::Migration[7.1]
  def change
    add_column :establishments, :city, :string
  end
end
