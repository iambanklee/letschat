require 'rails_helper'

RSpec.describe "ChatRooms", type: :request do
  shared_context "invalid_chat_room" do
    context "when chat room does not exist" do
      let(:chat_room) { instance_double(ChatRoom, id: "not-exist") }

      it "returns 404 error" do
        request

        expect(response).to have_http_status(404)
      end
    end
  end

  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /chat_rooms/new" do
    subject(:request) do
      get new_chat_room_path, as: :turbo_stream
    end

    it "returns http success" do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to include(/<turbo-stream action="update" target="new_chat_room">/)
    end
  end

  describe "POST /chat_rooms" do
    subject(:request) do
      post chat_rooms_path, params: chat_room_params, as: :turbo_stream
    end

    context "with valid chat room params" do
      let(:chat_room_params) do
        { chat_room: { name: "chat_room_1" } }
      end

      it "returns http success" do
        request

        expect(response).to have_http_status(:success)
        expect(response.body).to include(/<turbo-stream action="update" target="new_chat_room">/)
      end
    end

    context "with invalid chat room params" do
      let(:chat_room_params) do
        { name: "chat_room_1" }
      end

      it "returns 400 errors" do
        request

        expect(response).to have_http_status(400)
      end
    end

  end

  describe "GET /chat_rooms/:id/join" do
    subject(:request) do
      get join_chat_room_path(chat_room), as: :turbo_stream
    end

    context "when chat room exist" do
      let(:chat_room) { create(:chat_room) }

      it "adds user to given chat room" do
        expect { request }.to change { user.reload.chat_rooms.size }.by(1)

        expect(response).to have_http_status(:success)
        expect(response.body).to include(/<turbo-stream action="update" target="my_chat_rooms_area">/)
        expect(response.body).to include(/<turbo-stream action="update" target="other_chat_rooms_area">/)
      end
    end

    include_context "invalid_chat_room"
  end

  describe "GET /chat_rooms/:id/leave" do
    subject(:request) do
      get leave_chat_room_path(chat_room), as: :turbo_stream
    end

    context "when chat room exist" do
      let(:chat_room) { create(:chat_room) }

      before do
        user.chat_room_users.create(chat_room: chat_room)
      end

      it "remove user from given chat room" do
        expect { request }.to change { user.reload.chat_rooms.size }.by(-1)

        expect(response).to have_http_status(:success)
        expect(response.body).to include(/<turbo-stream action="update" target="my_chat_rooms_area">/)
        expect(response.body).to include(/<turbo-stream action="update" target="other_chat_rooms_area">/)
      end
    end

    include_context "invalid_chat_room"
  end

  describe "GET /chat_rooms/:id/show" do
    subject(:request) do
      get chat_room_path(chat_room), as: :turbo_stream
    end

    context "when chat room exist" do
      let(:chat_room) { create(:chat_room) }

      it "returns http success" do
        request

        expect(response).to have_http_status(:success)
        expect(response.body).to include(/<turbo-stream action="update" target="chat_room_messages_area">/)
      end
    end

    include_context "invalid_chat_room"
  end
end
