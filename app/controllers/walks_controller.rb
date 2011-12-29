class WalksController < ApplicationController
  def index
    @walks = Walk.find(:all).reverse
  end

  def show
    @walk = Walk.find(params[:id])
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.create(params[:walk])
    @walk.user = current_user
    @walk.save
    redirect_to @walk
  end

  def edit
    @walk = Walk.find(params[:id])
  end

end
