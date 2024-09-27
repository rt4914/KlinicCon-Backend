class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :patient_profile,
                   foreign_key: true
      t.references :doctor_profile,
                   foreign_key: true
      t.timestamps
    end
  end
end
