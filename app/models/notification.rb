class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, :polymorphic => true

  after_commit :broadcast_me, on: :create

  scope :created_at_desc, -> { order(created_at: :desc) }

  def message
    if item_type == "Comment"
      if item.reply_id
        return "Your have 1 reply."
      else
        return "Your have 1 comment."
      end
    end
  end

  def channel_user_id
    if item_type == "Comment"
      if item.reply_id.present?
        return item.reply_id
      else
        return item.post.user_id
      end
    end
  end

  private
  def broadcast_me
    ActionCable.server.broadcast "UserNotificationChannel.#{channel_user_id}", { message: "New reply is coming" } if channel_user_id != user_id
  end
end
