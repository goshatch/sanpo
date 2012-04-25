class ProfilesController < ApplicationController
  def show
    @user = User.where(:username => params[:id]).first
    @walks = @user.walks
    @profile = @user.profile
  end
end
