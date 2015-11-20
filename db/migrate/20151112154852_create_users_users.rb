class CreateUsersUsers < ActiveRecord::Migration
  def change
    create_table :users_users do |t|
      t.integer  'active',               limit: 4,   default: 1, null: false
      t.string   'name',                 limit: 100,             null: false
      t.string   'lastname',             limit: 100
      t.string   'email',                limit: 100,             null: false
      t.string   'encrypted_password',   limit: 255
      t.string   'salt',                 limit: 200
      t.datetime 'updatedAt'
      t.datetime 'createdAt'
      t.datetime 'deletedAt'
      t.datetime 'lastConnection'
      t.string   'rfc',                  limit: 255
      t.string   'curp',                 limit: 255
      t.integer  'userType_id',          limit: 4
      t.datetime 'time_requested'
      t.string   'password_reset_token', limit: 255
    end

    create_table :users_usertypes, force: :cascade do |t|
      t.string 'name', limit: 255
    end
    add_index 'users_users', ['userType_id'], name: 'index_userTypes_on_userType_id', using: :btree

    create_table :users_relationships, force: :cascade do |t|
      t.integer  'owner_id',   limit: 4
      t.integer  'contact_id', limit: 4
      t.datetime 'created_at',           null: false
      t.datetime 'updated_at',           null: false
    end
    add_index 'users_relationships', ['owner_id'], name: 'index_relationships_on_owner_id', using: :btree

    add_foreign_key 'users_users', 'users_usertypes', column: 'userType_id', name: 'fk_users_usertypes_on_users_users'
    add_foreign_key 'users_relationships', 'users_users', column: 'owner_id', name: 'fk_users_users_on_users_relationships_owner'
    add_foreign_key 'users_relationships', 'users_users', column: 'contact_id', name: 'fk_users_users_on_users_relationships_contact'
  end
end
