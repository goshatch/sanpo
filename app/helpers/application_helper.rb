module ApplicationHelper
  def usage_stats
    users = User.count
    walks = Walk.count
    photos = Photo.count
    comments = Comment.count
    t("general.stats", {:users => users, :walks => walks, :photos => photos, :comments => comments})
  end

  def comments_count_text(number)
    if number == 0
      "No comments"
    elsif number == 1
      "1 comment"
    else
      "#{number} comments"
    end
  end

  def avatar_image_tag(user, size = "73x73")
    profile = user.profile
    if profile and profile.avatar.present?
      image_tag profile.avatar.url(:thumb), :size => size, :class => 'avatar'
    else
      image_tag "default_avatar.png", :size => size, :class => 'avatar defaultAvatar'
    end
  end
end
