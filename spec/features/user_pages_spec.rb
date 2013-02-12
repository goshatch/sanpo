# encoding: UTF-8
require 'spec_helper'

describe "User pages" do

  let(:user) { FactoryGirl.create(:valid_user) }
  let(:username) { user.username }
  subject { page }

  describe "User profile page" do
    before do visit profile_path( username ) end
    it { should have_content("#{username}’s walks") }
    it { should have_content("Total walked: #{user.total_km_walked} km") }
  end

  describe "Edit profile" do
    before do 
      signin(user)
      visit edit_user_registration_path(username) 
    end

    describe "page" do
      it { should have_selector('h2', text: "My profile") }
      it { should have_selector('h2', text: "My account") }
      it { should have_selector('h3', text: "Cancel my account") }
    end

    describe "with new valid email information" do
      let(:new_email){ "fedor@emiklio.beast" }
      before do
        within ".edit_user" do
          fill_in "Email",            with: new_email
          fill_in "Current password", with: user.password
          click_button "Update"
        end
      end

      it { should have_alert_message("You updated your account successfully.") }
      specify { user.reload.email.should == new_email }

      describe "new email should be shown in the edit page" do
        before do visit edit_user_registration_path(username) end
        it { should have_selector( 'input', value: new_email ) }
      end
    end
  end
end

