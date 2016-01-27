class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users_users do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :users_users, :avatar
  end
end
