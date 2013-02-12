require 'spec_helper'
require_relative './request_spec_helper'

describe "Sign-up requests" do

  subject { page }
  let(:submit) { "Join SANPO" }
  before do visit new_user_registration_path end

  it_should_behave_like "sign-up page"

  describe "with unvalid submission" do
    it "should not create new user" do
      expect { click_button submit }.not_to change(User, :count)
    end

    describe "after submission" do
      before do click_button submit end
      it { should have_content('error') }
      it_should_behave_like "sign-up page"
    end
  end

  describe "with valid submission" do
    let(:user) { FactoryGirl.build(:valid_user) }
    let(:username) { user.username }
    before do
      within ".signup" do
        fill_in "Username", with: username
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
      end
    end

    it "should create a new user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    describe "after submission" do
      before do click_button submit end
      it { should have_content(username) }
      it_should_behave_like "signed up page"
    end
  end
end
