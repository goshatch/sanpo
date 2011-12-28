class PhotosController < ApplicationController
  respond_to :html, :js

  def new
    @photo = Photo.new
    @photo.walk_id = params[:walk_id]
  end

  def create
    @photo = Photo.create(params[:photo])
    redirect_to walk_path(params[:walk_id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if current_user and @photo.walk.user == current_user
      @photo.destroy
    else
      raise "Forbidden!"
    end
  end

  def edit
  end

end
