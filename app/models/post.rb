class Post < ApplicationRecord
  belongs_to :group, counter_cache: :posts_count
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :created_at_desc, -> { order(created_at: :desc) }

  def able_to_remove_by? user
    user.posts.ids.include?(id) || user.admin?
  end
end
