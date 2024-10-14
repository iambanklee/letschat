require 'rails_helper'

RSpec.describe "ChatRooms", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/chat_rooms/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/chat_rooms/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /join" do
    it "returns http success" do
      get "/chat_rooms/join"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /leave" do
    it "returns http success" do
      get "/chat_rooms/leave"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/chat_rooms/show"
      expect(response).to have_http_status(:success)
    end
  end

end
