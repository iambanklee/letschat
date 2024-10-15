require 'rails_helper'

RSpec.describe ChatRoomChannel, type: :channel do
  let(:chat_room_id) { 1 }

  before do
    subscribe(chat_room_id: chat_room_id)
  end

  it "stream to the queue chat_room_ with given chat_room_id" do
    expect(subscription).to have_stream_from("chat_room_#{chat_room_id}")
  end
end
