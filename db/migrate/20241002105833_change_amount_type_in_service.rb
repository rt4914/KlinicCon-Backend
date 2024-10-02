class ChangeAmountTypeInService < ActiveRecord::Migration[7.1]
  def change
    change_table :services do |t|
      t.remove :amount
      t.monetize :amount, null: false
    end
  end
end
