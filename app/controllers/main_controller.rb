class MainController < ApplicationController
  def index
    @current_user = current_user
    @my_chat_rooms = @current_user.chat_rooms
    @other_chat_rooms = ChatRoom.all - @my_chat_rooms
  end
end
