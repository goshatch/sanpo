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
end
