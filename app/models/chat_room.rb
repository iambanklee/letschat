class ChatRoom < ApplicationRecord
  has_many :messages

  after_create_commit { broadcast_append_to "chat_room_", target: "other_chat_rooms", partial: "chat_rooms/other_chat_room" }
end
