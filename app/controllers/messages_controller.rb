class MessagesController < ApplicationController
  def index
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @messages = @chat_room.messages.order(:created_at)
    @chat_room_users = ChatRoomUser.where(chat_room: @chat_room)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])

    @message = @chat_room.messages.new(message_params)
    @message.chat_room = @chat_room
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
