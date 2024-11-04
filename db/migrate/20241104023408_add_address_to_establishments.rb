class AddAddressToEstablishments < ActiveRecord::Migration[7.1]
  def change
    add_column :establishments, :address, :string
  end
end
