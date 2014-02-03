require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    describe "title" do
      it { should have_title('Sign In')}
    end
    
    describe "Form" do
      it { should have_content('Sign In')}
      it { should have_field('Username or Email')}
      it { should have_field('Password')}
    end
    
    describe "Signup from login" do
      it { should have_content("Don't have an account?")}
      it { should have_link("Signup", href: signup_path)}
    end
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in"}
      
      it { should have_title('Sign In')}
      it { should have_selector('div.alert.alert-error')}
    end
    
    describe "with valid information" do
      it "should create a session"
      it "should redirect to the user's profile"
      it "should remove login/signup links"
      it "should provide link logout"
      it "should provide account settings link"
      it "should provide logged in specific links"
      it "should update backend/monitoring for login"
    end
  end
end
