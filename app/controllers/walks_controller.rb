class WalksController < ApplicationController
  def index
    @walks = Walk.find(:all)
  end

  def show
    @walk = Walk.find(params[:id])
  end

  def new
    @walk = Walk.new
  end

  def edit
    @walk = Walk.find(params[:id])
  end

end
