require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe "Action Cable (Broadcasting)" do
    context "when a Chat room is created" do
      subject(:chat_room_creation) do
        chat_room.save
      end

      let(:chat_room) { build(:chat_room) }

      it "broadcasts message to right channel with predefined partial" do
        expect { chat_room_creation }
          .to have_broadcasted_to("chat_room_")
          .from_channel(ChatRoomChannel)
          .with(/turbo-stream action="append" target="other_chat_rooms".*#{chat_room.name}/m).once
      end
    end
  end
end
