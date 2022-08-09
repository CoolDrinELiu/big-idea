module NotificationsHelper
  def notification_target_url record
    case record.item_type
    when "Comment"
      post_path(record.item&.post_id)
    when "GroupRequest"
      groups_path()
    end
  end
end
