class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :nick_name
      t.string :display_name
      t.string :avatar_big
      t.string :avatar_small
      t.string :avatar_medium
      t.string :plurk_uid
      t.string :token
      t.string :secret
      t.text :raw

      t.timestamps
    end
  end
end
