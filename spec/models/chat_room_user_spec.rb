require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  describe "Action Cable (Broadcasting)" do
    context "when a ChatRoomUser is created (user joins a chat room)" do
      subject(:chat_room_user_creation) do
        chat_room_user.save
      end

      let(:user) { create(:user) }
      let(:chat_room) { create(:chat_room) }

      let(:chat_room_user) { build(:chat_room_user, chat_room: chat_room, user: user) }

      it "broadcasts message to right channel with predefined partial" do
        expect { chat_room_user_creation }
          .to have_broadcasted_to("chat_room_#{chat_room.id}")
          .from_channel(ChatRoomChannel)
          .with(/turbo-stream action="update" target="chat_room_user_count".*users in this room:1/m).once
      end
    end

    context "when a ChatRoomUser is destroy (user leaves a chat room)" do
      subject(:chat_room_user_destroy) do
        chat_room_user.destroy
      end

      let(:user) { create(:user) }
      let(:chat_room) { create(:chat_room) }

      let(:chat_room_user) { create(:chat_room_user, chat_room: chat_room, user: user) }

      it "broadcasts message to right channel with predefined partial" do
        expect { chat_room_user_destroy }
          .to have_broadcasted_to("chat_room_#{chat_room.id}")
          .from_channel(ChatRoomChannel)
          .with(/turbo-stream action="update" target="chat_room_user_count".*users in this room:0/m).once
      end
    end
  end
end
