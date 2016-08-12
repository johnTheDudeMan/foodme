class CreateKitchenIngredients < ActiveRecord::Migration
  def change
    create_table :kitchen_ingredients do |t|
      t.references :kitchen, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.integer :qty
      t.datetime :purchase_date, default: Time.zone.now

      t.timestamps null: false
    end
  end
end
