class AddFriendsCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends_cache, :text
    add_column :users, :friends_cache_updated_at, :datetime
  end
end
