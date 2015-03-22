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
  validate :picture_size
  belongs_to :user
  mount_uploader :picture, ::PictureUploader
  belongs_to :child
  has_many :comments, dependent: :destroy

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture_size, "should be less than 5MB")
    end
  end
end
