class SessionsController < ApplicationController
  def new
    # => Get action to render login page
  end
  
  def create
    # => Post action to validate login and create sessions
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      # => Successful login: signin and redirect to user dashboard
    else
      # => Unsuccessful login: provide error message and re-render new
      flash[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end
  
  def destroy
    # => Delete action used to delete the session (logging out)
  end
end
