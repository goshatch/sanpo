class PhotosController < ApplicationController
  def new
    @photo = Photo.new
    @photo.walk_id = params[:walk_id]
  end

  def create
    @photo = Photo.create(params[:photo])
    redirect_to walk_path(params[:walk_id])
  end

  def delete
  end

  def edit
  end

end
