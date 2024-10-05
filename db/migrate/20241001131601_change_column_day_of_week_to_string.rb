class ChangeColumnDayOfWeekToString < ActiveRecord::Migration[7.1]
  def change
    change_column :services, :day_of_week, :string
  end
end
