class ChatRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create :update_chat_room_user_counter
  after_destroy :update_chat_room_user_counter

  def update_chat_room_user_counter
    chat_room_user_counter = ChatRoomUser.where(chat_room: chat_room).size

    broadcast_update_to "chat_room_#{chat_room_id}", target: "chat_room_user_count", html: "<p>users in this room:#{chat_room_user_counter}</p>"
  end
end
