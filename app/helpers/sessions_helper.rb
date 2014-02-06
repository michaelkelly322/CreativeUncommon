module SessionsHelper
  def sign_in(user)
    session_key = User.new_session_key
    session[:session_key] = session_key
    user.update_attribute(:session_key, User.encrypt(session_key))
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    if @current_user.nil?
      session_key = User.encrypt(session[:session_key])
      @current_user = User.find_by(session_key: session_key)
    else
      @current_user
    end
  end
  
  def signed_in?
    !current_user.nil?
  end
end
