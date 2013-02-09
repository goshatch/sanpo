require 'spec_helper'

describe Profile do
  describe ".save!" do
    let(:valid_profile){ FactoryGirl.build(:profile) }
    it "should save a valid profile" do
      valid_profile.save!.should be_true
    end
  end
end
