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
    render :layout => 'fullwidth'
  end

  def new
    @walk = Walk.new
    @walk.user = current_user
    render :layout => 'fullwidth'
  end

  def create
    @walk = Walk.create(params[:walk])
    @walk.user = current_user
    @walk.save!
    redirect_to({:action => :show, :id => @walk.id, :n => "yes"})
  rescue ActiveRecord::RecordInvalid
    render :action => :new, :layout => "fullwidth"
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
      @walk.save
    end
  end

  def update
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
    @walk.update_attributes(params[:walk])
    respond_with @user
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
