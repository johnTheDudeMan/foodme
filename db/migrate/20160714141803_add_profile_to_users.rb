class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :blurb, :text
  end
end
