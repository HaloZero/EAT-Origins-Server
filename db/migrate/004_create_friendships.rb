class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :old_friend_id
      t.integer :new_friend_id
      t.string :relationship_type
      t.text :story
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
