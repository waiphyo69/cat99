
class User < ActiveRecord::Base
  validates :user_name,:password_digest,presence: true

  has_many :cats
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

end
