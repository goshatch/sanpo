require 'spec_helper'

describe User do

  subject { @user }

  before do @user = FactoryGirl.build(:valid_user) end

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should be_valid }

  describe ".save!" do

    before do @user.save! end

    it { should be_true }
   
    it "should have an attached profile" do
      @user.profile.should_not be_nil
    end
  end

  describe "when name is missing" do
    before do @user = FactoryGirl.build(:invalid_name_user) end
    it { should_not be_valid }
  end

  describe "when email is already in DB" do
    before do
      user_duplicate = @user.dup
      user_duplicate.email = @user.email.upcase # Should be case insensitive.
      user_duplicate.save!
    end
    it { should_not be_valid }
  end

  describe "when passwords are missing" do
    before do @user.password = @user.password_confirmation = " " end
    it { should_not be_valid }
  end

  describe "when passwords do not match" do
    before do @user.password_confirmation = "mismatchingPW" end
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before do @user.password_confirmation = nil end
    it { should be_valid }
  end

  describe "email with mixed case" do
    let(:mixed_case_email) { "Foo@eXaMPle.CoM" }
    it "should be saved in lowercase" do
      @user.email = mixed_case_email
      @user.save!
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

end
