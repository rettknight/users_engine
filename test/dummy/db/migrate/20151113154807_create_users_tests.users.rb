# This migration comes from users (originally 20151113154710)
class CreateUsersTests < ActiveRecord::Migration
  def change
    create_table :users_tests do |t|

      t.timestamps null: false
    end
  end
end
