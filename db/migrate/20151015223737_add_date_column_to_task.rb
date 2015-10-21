class AddDateColumnToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :date, :string
  end
end
