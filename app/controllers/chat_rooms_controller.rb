class ChatRoomsController < ApplicationController
  def new
    @chat_room = ChatRoom.new

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)

    respond_to do |format|
      if @chat_room.save
        format.turbo_stream
      end
    end
  end

  def join
    chat_room = ChatRoom.find(params[:id])
    @chat_room_user = current_user.chat_room_users.new(chat_room: chat_room)

    respond_to do |format|
      if @chat_room_user.save
        @my_chat_rooms = @current_user.chat_rooms
        @other_chat_rooms = ChatRoom.all - @my_chat_rooms

        format.turbo_stream
      end
    end
  end

  def leave
    chat_room = ChatRoom.find(params[:id])
    @chat_room_user = current_user.chat_room_users.find_by(chat_room: chat_room)

    respond_to do |format|
      if @chat_room_user.destroy
        @my_chat_rooms = @current_user.chat_rooms
        @other_chat_rooms = ChatRoom.all - @my_chat_rooms

        format.turbo_stream
      end
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
