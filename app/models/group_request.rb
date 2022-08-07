class GroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: { pending: 0, rejected: 1, approved: 2}
end
