class UserMailer < ActionMailer::Base
  default from: "admin@fuinneamh.com"
  
  def welcome_email(user)
    @user = user
    @url = 'http://fuinneamh.com/login'
    mail(to: @user.email, subject: 'Welcome to Fuinneamh!')
  end
end
