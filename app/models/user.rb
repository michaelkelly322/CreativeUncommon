class User < ActiveRecord::Base
  # => Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PWD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/  # minimum 8 characters, must contain 1 letter and 1 number
  
  # => Password infrastructure
  has_secure_password
  
  has_many :works
  
  validates :email,
            presence: true,
            length: { maximum: 50 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
            
  
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  
  validates :password, length: { minimum: 8 },
                       format: { with: VALID_PWD_REGEX },
                       if: :validate_password?
                       
  
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
  
  def send_welcome_email
    begin
      welcome = UserMailer.welcome_email(self)
      welcome.deliver
    rescue
      logger.error welcome.errors.inspect
    end
  end
  
  # => Private methods
  private
    def create_session_key
      self.session_key = User.encrypt(User.new_session_key)
    end
    
    def validate_password?
      password.present? || password_confirmation.present?
    end
end
