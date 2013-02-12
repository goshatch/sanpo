require 'spec_helper'

describe PhotosController do

  describe "GET 'new'" do
    context "an unauthenticated user" do
      it "should http redirect" do
        get :new
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      let(:user) { FactoryGirl.create(:valid_user) }
      it "should not redirect" do
        sign_in :user, user
        get :new
        response.should_not be_redirect
      end
    end
  end

  describe "GET 'create'" do
    context "an unauthenticated user" do
      it "should http redirect" do
        post :create
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      let(:walk) { FactoryGirl.create(:walk) }
      let(:user) { FactoryGirl.create(:valid_user) }
      let(:valid_params) { { :walk_id => walk.id, :photo => { :image => 'xxx', :image_file_name => 'xxx.jpg' } } }
      context "submits a valid photo" do
        it "should redirect to the walk_path" do
          sign_in :user, user
          post :create, valid_params
          response.should redirect_to(walk_path(walk))
        end
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
      let(:user) { FactoryGirl.create(:valid_user) }
      let(:walk) { FactoryGirl.create(:walk, :user => user) }
      let(:photo) { FactoryGirl.create(:photo, :walk => walk) }
      let(:valid_params) { { :id => photo.id, :format => 'js' } }
      it "should not redirect" do
        sign_in :user, user
        get :destroy, valid_params
        response.should_not be_redirect
      end
    end
  end
end
