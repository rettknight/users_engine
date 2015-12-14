class UsersPicture < ActiveRecord::Migration
  def change
  	add_column :users_pictures, :user_id, :integer, limit: 11
  end
end
