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
  has_many :posts, dependent: :destroy
  mount_uploader :picture, PictureUploader
  belongs_to :user
end
