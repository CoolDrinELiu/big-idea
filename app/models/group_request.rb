class GroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: { pending: 0, rejected: 1, approved: 2}
  # active means it was requested by the user_id
  enum direction: { active: 0, passive: 1}

  def add_member!
    transaction do
      approved!
      group.join! User.find(user_id)
    end
  end

  def accept_the_invitation!
    transaction do
      approved!
      group.join! User.find(user_id)
    end
  end
end
