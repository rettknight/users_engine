class RemoveStuffFromDb < ActiveRecord::Migration
  def change
    remove_column :users_users, :curp
    remove_column :users_users, :rfc
  end
end
