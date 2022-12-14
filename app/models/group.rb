class Group < ApplicationRecord
  has_many :user_group_relationships, dependent: :destroy
  has_many :members, through: :user_group_relationships, source: :user, dependent: :destroy
  has_many :group_requests, dependent: :destroy
  has_many :posts, dependent: :destroy

  scope :created_at_desc, -> { order(created_at: :desc) }

  enum access_control: {in_public: 0, in_private: 1, in_secret: 2}

  def has_member? user_id
    members.where(users: {id: user_id}).any?
  end

  def set_owner user
    update(user_id: user.id)
  end

  def owned_by? user
    user && user_id == user.id
  end

  def remove_owner
    update(user_id: nil)
  end

  def kick_out_member! user_id
    user_group_relationships.where(user_id: user_id).destroy_all
  end

  def quit! user
    return if user.blank?
    transaction do
      user_group_relationships.where(user_id: user.id, group_id: id).destroy_all
      remove_owner if user_id == user.id
    end
  end

  def join! user
    return if user.blank?
    relation = user_group_relationships.new(user_id: user.id, group_id: id)
    relation.save
  end

  def request_join! user, direction = "active", inviter_id = nil
    attrs_options = { user_id: user.id, direction: direction, inviter_id: inviter_id }
    the_req = group_requests.where(attrs_options).first
    # Can only be created the request when the request is rejected or it's not existed
    if the_req.blank? || (the_req && !the_req.pending?)
      request = group_requests.new(attrs_options)
      request.save
    else
      true
    end
  end

  def can_access_by? user
    return false if user.blank?
    return true if user.id == user_id
    return true if has_member? user.id
    return false
  end

  def create_post attributes
    posts.create attributes
  end
  private

  after_create :put_owner_in_members
  def put_owner_in_members
    user_group_relationships.create(user_id: user_id, group_id: id) if user_id
  end
end
