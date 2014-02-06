class User < ActiveRecord::Base
  # => Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # => Password infrastructure
  has_secure_password
  
  validates :email,
            presence: true,
            length: { maximum: 50 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
            
  
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  
  validates :password, length: { minimum: 8 }
  
  # => Callbacks
  before_save { self.email = email.downcase }
  before_create :create_session_key
  
  # => Class methods
  def User.new_session_key
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(key)
    Digest::SHA1.hexdigest(key.to_s)
  end
  
  # => Private methods
  private
    def create_session_key
      self.session_key = User.encrypt(User.new_session_key)
    end
end
