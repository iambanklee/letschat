require "rails_helper"
require "capybara/rails"

RSpec.describe User, type: :feature do
  describe "Users should be able to sign up and be authenticated" do
    describe "sign up" do
      it "allow users to sign up with display name" do
        visit '/users/sign_up'

        expect(page).to have_content 'Sign up'

        within("#new_user") do
          fill_in 'Email', with: "test@gamil.com"
          fill_in 'Display name', with: "Test User"
          fill_in 'Password', with: "password1"
          fill_in 'Password confirmation', with: "password1"
        end
        click_button 'Sign up'


        expect(page).to have_content 'Hello, Test User'
      end
    end

    describe "Authentication" do
      context "when user is not sign in" do
        it "redirect user to sign in page" do
          visit '/main/index'

          expect(page).to have_content 'Log in'
        end
      end

      context "allow users to sign in" do
        let!(:user) { create(:user) }

        it "redirect user to root page" do
          visit '/main/index'

          expect(page).to have_content 'Log in'

          within("#new_user") do
            fill_in 'Email', with: "#{user.email}"
            fill_in 'Password', with: "#{user.password}"
          end
          click_button 'Log in'

          expect(page).to have_content 'Hello, Test User'
        end
      end
    end
  end

  describe "Users should be able to join and leave chat rooms", js: true do
    let!(:user) { create(:user) }
    let!(:chat_room) { create(:chat_room) }

    before do
      sign_in user
    end

    it "user can join a chat room" do
      visit "/"

      within(".my_chat_rooms") do
        expect(page).not_to have_content("#{chat_room.name}")
      end

      within(".other_chat_rooms") do
        expect(page).to have_content("#{chat_room.name}")
      end

      click_link "#{chat_room.name}"

      within(".my_chat_rooms") do
        expect(page).to have_content("#{chat_room.name}")
      end

      within(".other_chat_rooms") do
        expect(page).not_to have_content("#{chat_room.name}")
      end
    end

    it "user can leave a chat room" do
      create(:chat_room_user, chat_room: chat_room, user: user)

      visit "/"

      within(".my_chat_rooms") do
        expect(page).to have_content("#{chat_room.name}")
      end

      within(".other_chat_rooms") do
        expect(page).not_to have_content("#{chat_room.name}")
      end

      click_link "Leave"

      within(".my_chat_rooms") do
        expect(page).not_to have_content("#{chat_room.name}")
      end

      within(".other_chat_rooms") do
        expect(page).to have_content("#{chat_room.name}")
      end
    end
  end

  describe "Chat rooms can have many users at a time", js: true do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    before do
      sign_in user

      create(:chat_room_user, chat_room: chat_room, user: user)
      create(:chat_room_user, chat_room: chat_room, user: another_user)
    end

    it "shows how many user in the chat room" do
      visit "/"

      click_link "#{chat_room.name}"

      within("#chat_room_user_count") do
        expect(page).to have_content("users in this room:2")
      end
    end
  end

  describe "Users can send message to chat rooms", js: true do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    before do
      sign_in user

      create(:chat_room_user, chat_room: chat_room, user: user)
      create(:chat_room_user, chat_room: chat_room, user: another_user)
    end

    it "allow user to sends message" do
      visit "/"

      click_link "#{chat_room.name}"

      within("#char_room_messages") do
        fill_in "message[content]", with: "Hello there"
        click_button "Send"
      end

      within("#new_messages") do
        expect(page).to have_content("Hello there")
      end
    end
  end
end
