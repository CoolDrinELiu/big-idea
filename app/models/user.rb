class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_group_relationships
  has_many :owned_groups, class_name: "Group", foreign_key: :user_id
  has_many :member_groups, through: :user_group_relationships, foreign_key: 'user_id', source: :group
  has_many :group_requests
  has_many :posts
  has_many :comments
  has_many :notifications

end
