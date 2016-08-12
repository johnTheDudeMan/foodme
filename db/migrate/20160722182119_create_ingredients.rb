class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :type
      t.integer :shelf_life
      t.string :store_room

      t.timestamps null: false
    end
  end
end
