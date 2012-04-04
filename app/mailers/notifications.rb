class Notifications < ActionMailer::Base
  default from: "SANPO <contact@sanpo.cc>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  # def signup
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_comment_on_walk.subject
  #
  def new_comment_on_walk(comment)
    @comment = comment
    mail to: comment.walk.user.email
  end

  def new_comment_after_your_comment(commenter, comment)
    @commenter = commenter
    @comment = comment
    mail to: commenter.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_walk_near_me.subject
  #
  # def new_walk_near_me
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end
end
