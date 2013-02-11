require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "User profile page" do
    let(:user) { FactoryGirl.create(:valid_user) }
    let(:username) { user.username }
    before do visit profile_path( username ) end
    it { should have_content("#{username}'s walks") }
    it { should have_content("Total walked: #{user.total_km_walked} km") }
  end

  describe "signup" do
    let(:submit) { "Join SANPO" }
    before do visit new_user_registration_path end

    describe "with unvalid submission" do
      it "should not create new user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    describe "with valid submission" do
      before do
        within ".signup" do
          fill_in "Username", with: "Pekka"
          fill_in "Email",    with: "pekka@hsk.fi"
          fill_in "Password", with: "HakkaPeliitta"
        end
      end
      it "should create a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end

