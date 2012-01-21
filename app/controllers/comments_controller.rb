class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment])
  end

  def update
    @comment = Comment.find(params[:id])
    raise "Permission denied" unless @comment.user == current_user
    @comment.update_attributes(params[:comment])
    respond_with_bip(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    raise "Permission denied" unless @comment.user == current_user
    @comment.destroy
    @deleted_comment_id = params[:id]
  end
end
