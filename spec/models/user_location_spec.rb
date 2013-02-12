require 'spec_helper'

describe UserLocation do
  describe ".save!" do
    let(:valid_user_location){ FactoryGirl.build(:user_location) }
    it "should save a valid location" do
      saved_loc = valid_user_location.save!
      saved_loc.should be_true
      valid_user_location.latitude.round.should eq(59)
      valid_user_location.longitude.round.should eq(18)
    end
  end
end
