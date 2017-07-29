class CreateRatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :rate_plans do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :reccurence
      t.float :price

      t.timestamps
    end
  end
end
