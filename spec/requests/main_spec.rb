require 'rails_helper'

RSpec.describe "Mains", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  context "with signed in user" do
    describe "GET /index" do
      subject(:request) { get "/main/index" }

      it "returns http success" do
        request

        expect(response).to have_http_status(:success)
      end
    end
  end
end
