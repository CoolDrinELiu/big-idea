class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, :polymorphic => true

  after_commit :broadcast_me, on: :create

  scope :created_at_desc, -> { order(created_at: :desc) }

  def output_data
    if item_type == "Comment"
      if item.reply_id
        return ["Your have 1 reply.", item.reply_id]
      else
        return ["Your have 1 comment.", item.post.user_id]
      end
    elsif item_type == "GroupRequest"
      return ["You are been invited to a secret group.", item.user_id]
    end
  end

  def channel_user_id
    output_data[1]
  end

  def message
    output_data[0]
  end

  def post_or_comment_by_self?
     item_type == "Comment" && item.post.user_id == item.user_id && item.reply_id.blank?
  end

  private
  def broadcast_me
    ActionCable.server.broadcast "UserNotificationChannel.#{channel_user_id}", { message: "New reply is coming" } if !post_or_comment_by_self?
    ActionCable.server.broadcast "UserNotificationChannel.#{channel_user_id}", { message: "Someone invited you" } if item_type == "GroupRequest"
  end
end
