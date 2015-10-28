class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :total
      t.integer :trip_id
      t.string :date

      t.timestamps null: false
    end
  end
end
