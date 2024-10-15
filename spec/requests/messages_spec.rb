require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /chat_rooms/:chat_room_id/messages" do
    subject(:request) do
      get "/chat_rooms/#{chat_room.id}/messages", as: :turbo_stream
    end

    let(:chat_room) { create(:chat_room) }

    it "returns http success" do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to include(/<turbo-stream action="update" target="chat_room_messages_area">/)
    end
  end

  describe "POST /chat_rooms/:chat_room_id/messages" do
    subject(:request) do
      post "/chat_rooms/#{chat_room.id}/messages", params: message_params, as: :turbo_stream
    end

    let(:chat_room) { create(:chat_room) }
    let(:message_params) do
      { message: { content: "new message" } }
    end

    it "returns http success" do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to include(/<turbo-stream action="remove" target="does-not-exist">/)
    end

    it "creates a new message for given chat room" do
      expect { request }.to change { chat_room.reload.messages.size }.by(1)

      message = Message.last

      expect(message.chat_room).to eq(chat_room)
      expect(message.user).to eq(user)
      expect(message.content).to eq("new message")
    end
  end
end
