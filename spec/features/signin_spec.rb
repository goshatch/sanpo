require 'spec_helper'
require_relative './request_spec_helper'

describe "Sign-in requests" do
  
  subject { page }
  let(:login) { "Sign in" }
  let(:signin_user_path) { new_user_session_path }
  before { visit signin_user_path }

  it_should_behave_like "sign-in page"

  describe "with invalid sign-in information" do
    before do click_button login end
    it_should_behave_like "sign-in page"
    it { should have_alert_message("Invalid email or password.") }
  end

  describe "with valid sign-in information" do
    let(:user) { FactoryGirl.create(:valid_user) }

    before do fillin_and_signin(user) end

    it_should_behave_like "signed in page"
    describe "followed by signing out" do
      before { click_link "Sign out" }
      it_should_behave_like "signed out page"
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:valid_user) }

      describe "in the Users controller" do

        describe "get the edit page" do
          before { visit edit_user_registration_path(user.username) }
          it { should have_content("You need to sign in or sign up before continuing.") }
        end

        describe "update the profile" do
          before { put user_registration_path(user.username) }
          specify { response.should_not be_success }
        end
      end
    end
  end
end
