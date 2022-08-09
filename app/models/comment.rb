class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :post
  belongs_to :reply_to, class_name: 'User', optional: true, foreign_key: 'reply_id'

  scope :created_at_desc, -> { order(created_at: :desc) }

  after_create :create_notification

  def create_notification
    target_user_id = reply_id ? reply_id : post.user_id
    Notification.create(item_id: id, item_type: self.class.name, user_id: target_user_id)
  end
end
