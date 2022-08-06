class UserGroupRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :group, counter_cache: :members_count
end
