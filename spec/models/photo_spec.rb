require 'spec_helper'

describe Photo do
  let(:valid_photo){ FactoryGirl.build(:photo) }
  it "should save a valid photo" do
    valid_photo.save!.should be_true
  end
end
