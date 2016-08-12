class AddKitchenToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :kitchen, index: true, foreign_key: true
  end
end
