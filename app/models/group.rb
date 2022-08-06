class Group < ApplicationRecord
  has_many :members, through: :user_group_relationships, source: :user, dependent: :destroy
  has_many :user_group_relationships
end
