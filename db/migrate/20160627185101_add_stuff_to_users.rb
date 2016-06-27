class AddStuffToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true
  	add_column :users, :password_digest, :string
  	add_column :users, :remember_digest, :string
  	add_column :users, :admin, :boolean, default: false
  	add_column :users, :activation_digest, :string
  	add_column :users, :activated, :boolean, default: false
  	add_column :users, :activated_at, :datetime
  	add_column :users, :pw_reset_digest, :string
  	add_column :users, :pw_reset_sent_at, :datetime
  end
end
