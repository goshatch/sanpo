class WalksController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update_waypoints]

  def index
    @walks = Walk.find(:all).reverse
  end

  def show
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
    redirect_to @walk
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

  def edit
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
  end

end
