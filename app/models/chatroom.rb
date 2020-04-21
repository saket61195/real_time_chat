class Chatroom < ApplicationRecord
	has_many :chatroom_users, dependent: :destroy
	has_many :users, through: :chatroom_users
	has_many :messages, dependent: :destroy

	scope :public_channels, ->{where(direct_message: false)}
	scope :direct_messages, ->{where(direct_message: true)}

	def self.direct_message_for_users(users)
		users_ids = users.map(&:id).sort
		name = "DM:#{users_ids.join(":")}"

		if chatroom = direct_messages.where(name: name).first
			chatroom
		else
			#creating new chat chatroom
			chatroom = new(name: name, direct_message: true)
			chatroom.users = users
			chatroom.save
			Chatroom
		end
	end
end
