class WalksController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update_waypoints, :update]
  respond_to :html, :json

  def index
    @walks = Walk.find(:all).reverse
  end

  def show
    if params[:n] == "yes"
      @new_walk = true
    end
    @walk = Walk.find(params[:id])
    if current_user
      @comment = Comment.new
      @comment.walk = @walk
      @comment.user = current_user
      if @walk.user == current_user
        @photo = Photo.new
        @photo.walk = @walk
      end
    end
  end

  def new
    @walk = Walk.new
    @walk.user = current_user
  end

  def create
    @walk = Walk.create(params[:walk])
    @walk.user = current_user
    @walk.save!
    redirect_to({:action => :show, :id => @walk.id, :n => "yes"})
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def update_waypoints
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
    parsed_json = JSON.parse(params[:waypoints])
    if parsed_json
      @walk.waypoints.destroy_all
      parsed_json.each do |waypoint|
        @walk.waypoints << Waypoint.create(
          :latitude => waypoint["latitude"],
          :longitude => waypoint["longitude"],
          :step_num => waypoint["step_num"]
        )
      end
      @walk.length = params[:length]
      @walk.save
    end
  end

  def publish
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
    if @walk.photos.count > 0
      @success = true
      @walk.published = true
      @walk.published_at = Time.now
      @walk.save
    else
      @success = false
    end
  end

  def update
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
    @walk.update_attributes(params[:walk])
    respond_with_bip(@walk)
  end

  def edit
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
  end

  def destroy
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
    @walk.destroy
    redirect_to walks_path
  end

end
