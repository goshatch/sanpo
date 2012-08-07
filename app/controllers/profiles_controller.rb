class ProfilesController < ApplicationController
  def show
    @user = User.where(:username => params[:id]).first
    @walks = @user.walks
    @profile = @user.profile
  end

  def create
    @profile = params[:profile]
    @profile.user = current_user
    @profile.save
  end
end
