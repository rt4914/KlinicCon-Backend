class CreateInstitutes < ActiveRecord::Migration[7.1]
  def change
    create_table :institutes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :institutes, :name, unique: true
  end
end
