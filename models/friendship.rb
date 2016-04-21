class Friendship < ActiveRecord::Base
	validates :old_friend_id, presence: true
	validates :new_friend_id, presence: true

	def new_friendship(old_friend, new_friend)
		Friendship.create(
			old_friend_id: old_friend.id, 
			new_friend_id: new_friend_id
		)
	end

	def old_friend()
		User.find(self.old_friend_id)
	end

	def new_friend()
		User.find(self.new_friend_id)
	end

	def to_json()
		{
			old_friend: self.old_friend.to_json,
			new_friend: self.new_friend.to_json,
			type: self.relationship_type,
			story: self.story
		}
	end

end
