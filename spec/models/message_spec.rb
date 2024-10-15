require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Action Cable (Broadcasting)" do
    context "when a Message is created" do
      subject(:message_creation) do
        message.save
      end

      let(:user) { create(:user) }
      let(:chat_room) { create(:chat_room) }

      let(:message) { build(:message, chat_room: chat_room, user: user) }

      it "broadcasts message to right channel with predefined partial" do
        expect { message_creation }
          .to have_broadcasted_to("chat_room_#{chat_room.id}")
          .from_channel(ChatRoomChannel)
          .with(/turbo-stream action="append" target="new_messages".*#{message.content}/m).once
      end
    end
  end
end
