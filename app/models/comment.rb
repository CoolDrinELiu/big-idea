class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :post
  belongs_to :reply, class_name: 'Comment', optional: true

  scope :created_at_desc, -> { order(created_at: :desc) }
end
