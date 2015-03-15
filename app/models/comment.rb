# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :content, :user_id, :post_id, presence: true
  belongs_to :user
  belongs_to :post
end
