class Post < ActiveRecord::Base
  validates :content, :user_id, :child_id, :picture, presence: true
end
