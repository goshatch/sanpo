require 'spec_helper'

describe User do

  subject { @user }

  before do @user = FactoryGirl.build(:valid_user) end

  it { should respond_to(:username) }
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

end
