# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#  admin           :boolean          default("false")
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token
  attr_reader :password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :children

  def self.generate_session_token
    begin
      token = SecureRandom.urlsafe_base64
    end until !self.exists?(:session_token => token)
    token
  end

  def self.find_by_credentials(email, password)
    @user = self.find_by_email(email)
    if @user.nil? || !@user.is_password?(password)
      @user = nil
    end
    @user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
