class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :walk

  def self.send_notification(id)
    find(id).send_notification
  end

  def self.send_notification_to_previous_commenters(id, current_user_id)
    find(id).send_notification_to_previous_commenters(current_user_id)
  end

  def send_notification
    if self.walk.user.mail_comment_notification
      Notifications.new_comment_on_walk(self).deliver
    end
  end

  def send_notification_to_previous_commenters(current_user_id)
    commenters = self.walk.comments.collect { |comment| comment.user }
    commenters.uniq.each do |commenter|
      if commenter.mail_comment_notification
        Notifications.new_comment_after_your_comment(commenter, self).deliver unless (commenter.id == current_user_id or commenter.id == self.walk.user.id)
      end
    end
  end
end
