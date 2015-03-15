# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer          not null
#  child_id   :integer          not null
#  picture    :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :content, :user_id, :child_id, :picture, presence: true
  belongs_to :user
  belongs_to :child
  has_many :comments, dependent: :destroy
end
