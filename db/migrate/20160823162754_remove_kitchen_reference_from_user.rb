class RemoveKitchenReferenceFromUser < ActiveRecord::Migration
  def change
    remove_reference :users, :kitchen, index: true, foreign_key: true
  end
end
