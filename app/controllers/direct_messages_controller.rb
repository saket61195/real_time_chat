class DirectMessagesController < ApplicationController

	def show
		users = [current_user, User.find(params[:id])]
		@chatroom = Chatroom.direct_message_for_users(users)
		@messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
		render 'chatrooms/show'
	end
end
