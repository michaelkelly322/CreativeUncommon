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
  
  def get_user_image
    @user = User.find(params[:id])
    
#    if File.exists? Rails.root.join('public', 'uploads', @user.id.to_s)
#      send_file Rails.root.join('public', 'uploads', @user.id), :type => 'image/jpeg', :disposition => 'inline'
#    end
    
    respond_to do |format|
      format.jpg {Rails.root.join('public', 'uploads', @user.id)}
    end
  end
  
  def show
    @user = User.find(params[:id])
    @popular = @user.works.order(read_count: :desc).first
  end
  
  def update
    @user = User.find(params[:id])
    uploaded = params[:user][:image]
    
    @user.update_attribute(:image, uploaded.read)
    
    File.open(Rails.root.join('public', 'uploads', @user.id, 'wb')) do |file|
      file.write(uploaded.read)
    end
    
    redirect_to @user
  end
  
  def edit
    if signed_in?
      @user = current_user
    else
      @user = User.find(params[:id])
      redirect_to @user
    end
  end
  
  def stories
    if !signed_in?
      redirect_to search_path
    end
    
    @user = current_user
    @works = @user.works
  end
  
  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
