class AddUserToTopic < ActiveRecord::Migration
  def change
    add_reference :topics, :user, index: true
    if first_admin = User.find_by(nick_name: Array(Settings.admin_nick_names).first)
      Topic.update_all user_id: first_admin.id
    end
  end
end
