require 'spec_helper'

describe "Authentication pages" do
  subject { page }

  describe "Sign up page" do
    before { visit new_user_registration_path }
    it { should have_content('Please sign up!') }
  end

  describe "Sign in page" do
    before { visit user_session_path }
    it { should have_content('Sign in!') }
  end
end
