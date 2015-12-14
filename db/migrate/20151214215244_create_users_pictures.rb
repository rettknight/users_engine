class CreateUsersPictures < ActiveRecord::Migration
  def change
    create_table :users_pictures do |t|
      t.attachment :url
      t.timestamps null: false
    end
  end
end
