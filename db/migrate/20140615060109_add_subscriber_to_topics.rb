class AddSubscriberToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :subscriber_id, :integer
    add_index :topics, :subscriber_id
  end
end
