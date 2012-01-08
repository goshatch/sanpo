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
  end

  def create
    @walk = Walk.create(params[:walk])
    @walk.user = current_user
    @walk.save
    redirect_to @walk
  end

  def update_waypoints
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user


  end

  def edit
    @walk = Walk.find(params[:id])
    raise "Permission denied" unless @walk.user == current_user
  end

end
