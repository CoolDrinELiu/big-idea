class GroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: { pending: 0, rejected: 1, approved: 2}

  def add_member!
    approved!
    group.join! User.find(user_id)
  end
end
