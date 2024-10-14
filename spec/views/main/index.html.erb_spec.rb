require 'rails_helper'

RSpec.describe "main/index.html.erb", type: :view do
  let!(:user) { create(:user) }
  let!(:chat_rooms) { create_list(:chat_room, 2) }

  before do
    assign(:current_user, user)
    assign(:my_chat_rooms, chat_rooms)
  end

  it "display user display name" do
    render

    expect(rendered).to include(/#{user.display_name}/)
  end

  it "display user's joined chat rooms" do
    render

    expect(rendered).to match(/My chat rooms/)
    expect(rendered).to match(/#{chat_rooms.first.name}/)
    expect(rendered).to match(/#{chat_rooms.last.name}/)
  end
end
