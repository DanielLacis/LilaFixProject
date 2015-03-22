# == Schema Information
#
# Table name: children
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string           not null
#  picture     :string           not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Child < ActiveRecord::Base
  validates :name, :description, :picture, :user_id, presence: true
  validate :picture, :picture_size
  has_many :posts, dependent: :destroy
  mount_uploader :picture, PictureUploader
  belongs_to :user

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture_size, "should be less than 5MB")
    end
  end
end
