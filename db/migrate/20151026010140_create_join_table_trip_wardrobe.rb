class CreateJoinTableTripWardrobe < ActiveRecord::Migration
  def change
    create_join_table :trips, :wardrobes do |t|
      t.index [:trip_id, :wardrobe_id]
      t.index [:wardrobe_id, :trip_id]
    end
  end
end
