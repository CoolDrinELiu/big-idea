class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, :polymorphic => true

  scope :created_at_desc, -> { order(created_at: :desc) }

  def message
    case item_type
    when "Comment"
      "Your have 1 reply."
    end
  end
end
