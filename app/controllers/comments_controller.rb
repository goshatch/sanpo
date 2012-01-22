class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment])
    if @comment.user != @comment.walk.user and @comment.walk.user.mail_comment_notification
      Comment.delay.send_notification(@comment.id)
    end
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
