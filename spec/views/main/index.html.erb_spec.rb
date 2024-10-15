require 'rails_helper'

RSpec.describe "main/index.html.erb", type: :view do
  let!(:user) { create(:user) }
  let!(:chat_rooms) { create_list(:chat_room, 2) }
  let!(:other_chat_rooms) { create_list(:chat_room, 2) }

  before do
    assign(:current_user, user)
    assign(:my_chat_rooms, chat_rooms)
    assign(:other_chat_rooms, other_chat_rooms)
  end

  it "display user display name" do
    render

    expect(rendered).to include(/#{user.display_name}/)
  end

  it "display chat rooms user joined" do
    render

    expect(rendered).to match(/My chat rooms.*#{chat_rooms.first.name}.*#{chat_rooms.last.name}/m)
  end

  it "display other chat rooms user can join" do
    render

    expect(rendered).to match(/Other chat rooms.*#{other_chat_rooms.first.name}.*#{other_chat_rooms.last.name}/m)
  end
end
