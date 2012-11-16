class PhotosController < ApplicationController
  respond_to :html, :js
  before_filter :authenticated?

  def new
  end

  def create
    @photo = Photo.create(params[:photo])
    if @photo.errors.empty?
      redirect_to walk_path(Walk.find(params[:walk_id]))
    else
      render 'photos/new'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if current_user and @photo.walk.user == current_user
      @photo.destroy
    else
      raise "Forbidden!"
    end
  end

end
