class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
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
    @popular = @user.works.order(read_count: :desc).first
  end
  
  def edit
    if signed_in?
      @user = current_user
    else
      @user = User.find(params[:id])
      redirect_to @user
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
