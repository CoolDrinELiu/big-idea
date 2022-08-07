class Post < ApplicationRecord
  belongs_to :group, counter_cache: :posts_count
end
