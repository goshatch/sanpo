require 'spec_helper'

describe CommentsController do

  describe "GET 'create'" do
    context "an unauthenticated user" do
      it "should http redirect" do
        get :create
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      let(:walk) { FactoryGirl.create(:walk) }
      let(:user) { FactoryGirl.create(:user) }
      let(:valid_params) { { :comment => { :walk_id => walk.id, :user_id => user.id }, :format => 'js' } }
      it "should not redirect" do
        sign_in :user, user
        get :create, valid_params
        response.should_not be_redirect
      end
    end
  end

  describe "GET 'udpate'" do
    context "an unauthenticated user" do
      it "should http redirect" do
        get :update
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:comment) { FactoryGirl.create(:comment, :user => user) }
      let(:new_text) { 'Fun stuff!' }
      let(:valid_params) { { :id => comment.id, :comment => { :text => new_text }, :format => 'js' } }
      it "should not redirect" do
        sign_in :user, user
        get :update, valid_params
        response.should_not be_redirect
        comment.reload
        comment.text.should eql(new_text)
      end
    end
  end

  describe "GET 'destroy'" do
    context "an unauthenticated user" do
      it "should http redirect" do
        get :destroy
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:comment) { FactoryGirl.create(:comment, :user => user) }
      let(:valid_params) { { :id => comment.id, :format => 'js' } }
      it "should not redirect" do
        sign_in :user, user
        get :destroy, valid_params
        response.should_not be_redirect
        user.comments.should be_empty
      end
    end
  end

end
