class CreateWardrobes < ActiveRecord::Migration
  def change
    create_table :wardrobes do |t|
      t.string :name
      t.integer :quantity
      t.boolean :reminder
      t.string :image_url

      t.timestamps null: false
    end
  end
end
