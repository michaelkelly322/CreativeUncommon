class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:notice] = "Welcome to the Creative Uncommon!"
      redirect_to @user
    else
      flash[:failure] = "Could not create user!"
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
