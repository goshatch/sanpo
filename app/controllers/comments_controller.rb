class CommentsController < ApplicationController
  before_filter :authenticated?
  
  def create
    @comment = Comment.create(params[:comment])
    @comment.user = current_user
    unless @comment.nil?
      if @comment.user != @comment.walk.user && @comment.walk.user.mail_comment_notification
        Comment.delay.send_notification(@comment.id)
      end
      if @comment.walk.comments.count > 1
        Comment.delay.send_notification_to_previous_commenters(@comment.id, current_user.id)
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    raise ApplicationController::AccessDenied unless @comment.user == current_user
    @comment.update_attributes(params[:comment])
    respond_with_bip(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    raise ApplicationController::AccessDenied unless @comment.user == current_user
    @comment.destroy
    @deleted_comment_id = params[:id]
  end
end
