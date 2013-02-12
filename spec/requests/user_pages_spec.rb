# encoding: UTF-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "User profile page" do
    let(:user) { FactoryGirl.create(:valid_user) }
    let(:username) { user.username }
    before do visit profile_path( username ) end
    it { should have_content("#{username}’s walks") }
    it { should have_content("Total walked: #{user.total_km_walked} km") }
  end

end

