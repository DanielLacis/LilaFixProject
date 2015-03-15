class Child < ActiveRecord::Base
  validates :name, :description, :picture, presence: true
end
