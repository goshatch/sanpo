require 'spec_helper'

describe WalksController do

  describe "GET 'index'" do
    context "an unauthenticated user" do
      it "should not redirect" do
        get :index
        response.should be_success
      end
    end
    context "an authenticated user" do
      let(:user) { FactoryGirl.create(:user) }
      it "should not redirect" do
        sign_in :user, user
        get :index
        response.should be_success
      end
    end
  end

  describe "GET 'show'" do
    let(:walk) { FactoryGirl.create(:walk) }
    let(:user) { FactoryGirl.create(:user) }
    let(:valid_params) { { :id => walk } }
    context "an unauthenticated user" do
      it "should show the walk" do
        get :show, valid_params
        response.should be_success
      end
    end
    context "an authenticated user" do
      it "should not redirect" do
        sign_in :user, user
        get :show, valid_params
        response.should be_success
      end
    end
  end

  describe "GET 'new'" do
    let(:user) { FactoryGirl.create(:user) }
    context "an unauthenticated user" do
      it "should redirect" do
        get :new
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      it "should not redirect" do
        sign_in :user, user
        get :new
        response.should be_success
      end
    end
  end

  describe "GET 'edit'" do
    let(:user) { FactoryGirl.create(:user) }
    let(:walk) { FactoryGirl.create(:walk, :user => user) }
    let(:valid_params) { { :id => walk } }
    context "an unauthenticated user" do
      it "should show the walk" do
        get :edit, valid_params
        response.should be_redirect
      end
    end
    context "an authenticated user" do
      context "trying to edit their own walk" do
        it "should be success" do
          sign_in :user, user
          get :edit, valid_params
          response.should be_success
        end
      end
      
      context "trying to edit someone else's walk" do
        it "should not be success" do
          sign_in :user, FactoryGirl.create(:user)
          get :edit, valid_params
          response.should redirect_to('/401.html')
        end
      end
    end
  end

end
