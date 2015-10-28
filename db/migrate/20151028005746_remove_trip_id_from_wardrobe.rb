class RemoveTripIdFromWardrobe < ActiveRecord::Migration
  def change
    remove_column :wardrobes, :trip_id, :integer
  end
end
