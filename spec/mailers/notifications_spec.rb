require "spec_helper"

describe Notifications do

  describe "new_comment_on_walk" do
    let(:comment) { FactoryGirl.create(:comment) }
    let(:mail) { Notifications.new_comment_on_walk(comment) }
    
    it "renders the headers" do
      mail.subject.should eq("A new comment on your walk!")
      mail.to.should eq([Walk.find(comment.walk_id).user.email])
      mail.from.should eq(["contact@sanpo.cc"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
