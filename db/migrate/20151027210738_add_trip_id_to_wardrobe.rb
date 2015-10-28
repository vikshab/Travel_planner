class AddTripIdToWardrobe < ActiveRecord::Migration
  def change
    add_column :wardrobes, :trip_id, :integer
  end
end
