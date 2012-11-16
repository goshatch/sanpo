require 'spec_helper'

describe User do
  
  describe ".save!" do
    let(:valid_user) { FactoryGirl.build(:user) }
    it "should save a valid user" do
      valid_user.save!.should be_true
    end
    
    it "should have an attached profile" do
      valid_user.save!
      valid_user.profile.should_not be_nil
    end
  end
end
