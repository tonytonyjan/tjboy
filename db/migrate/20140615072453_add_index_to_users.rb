class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :nick_name
    add_index :users, :plurk_uid
  end
end
