class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_class
      t.string :address
      t.string :unit
      t.string :url
      t.integer :price

      t.timestamps null: false
    end
  end
end
