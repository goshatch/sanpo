class ProfilesController < ApplicationController
  def show
    @user = User.where(:username => params[:id]).first
    @walks = @user.walks.reverse
    @profile = @user.profile
  end

  def create
    @profile = params[:profile]
    @profile.user = current_user
    @profile.save
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to edit_user_registration_path
    else
      render :partial => 'edit'
    end
  end
end
