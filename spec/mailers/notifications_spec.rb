require "spec_helper"

describe Notifications do
  describe "signup" do
    let(:mail) { Notifications.signup }

    it "renders the headers" do
      mail.subject.should eq("Signup")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "new_comment_on_walk" do
    let(:mail) { Notifications.new_comment_on_walk }

    it "renders the headers" do
      mail.subject.should eq("New comment on walk")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "new_walk_near_me" do
    let(:mail) { Notifications.new_walk_near_me }

    it "renders the headers" do
      mail.subject.should eq("New walk near me")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
