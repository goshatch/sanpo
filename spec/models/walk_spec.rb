require 'spec_helper'

describe Walk do
  let(:valid_walk) { FactoryGirl.build(:walk)}
  it "should save valid walk" do
    valid_walk.save!.should be_true
  end


end
