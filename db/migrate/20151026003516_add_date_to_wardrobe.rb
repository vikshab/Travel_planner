class AddDateToWardrobe < ActiveRecord::Migration
  def change
    add_column :wardrobes, :date, :string
  end
end
