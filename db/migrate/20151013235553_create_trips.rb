class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :destination
      t.string :start_date
      t.string :end_date
      t.string :image_url

      t.timestamps null: false
    end
  end
end
