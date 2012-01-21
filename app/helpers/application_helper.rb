module ApplicationHelper
  def usage_stats
    users = User.count
    walks = Walk.count
    photos = Photo.count
    comments = Comment.count
    t("general.stats", {:users => users, :walks => walks, :photos => photos, :comments => comments})
  end
end
