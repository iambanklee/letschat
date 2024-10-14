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

          expect(page).to have_content 'Sign up'
        end
      end

      context "when user is sign in" do
        before do
          create(:user)
        end

        it "redirect user to root page" do
          visit '/main/index'

          expect(page).to have_content 'Sign up'

          within("#new_user") do
            fill_in 'Email', with: "test@local.com"
            fill_in 'Password', with: "password1"
          end
          click_button 'Log in'

          expect(page).to have_content 'Hello, Test User'
        end
      end
    end
  end
end
