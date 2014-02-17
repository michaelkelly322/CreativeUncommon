require 'spec_helper'

describe "User pages", type: :feature do
  subject { page }
  
  describe "profile" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    
    describe "viewed as anonymous user" do
      before { visit user_path(user1) }
      
      it { should have_title(user1.first_name + ' ' + user1.last_name) }
      it { should have_content(user1.first_name + ' ' + user1.last_name) }
      it { should have_content(user1.bio) }
      
      it { should_not have_content(user1.email) }
      it { should_not have_link('Edit') }
    end
    
    describe "viewed as the logged in user" do
      before do
        visit signin_path
        fill_in 'Username or Email', with: user1.email
        fill_in 'Password', with: user1.password
        click_button 'Sign in'
      end
    
      it { should have_title(user1.first_name + ' ' + user1.last_name) }
      it { should have_content(user1.first_name + ' ' + user1.last_name) }
      it { should have_content(user1.bio) }
      it { should have_content(user1.email) }
      it { should have_link('Edit') }
    end
    
    describe "viewed as a logged in user" do
      it "should have content viewable by other logged in users"
    end
  end
  
  describe "signin" do
    before { visit signup_path }
    
    it { should have_field("First Name")}
    it { should have_field("Last Name")}
    it { should have_field("Bio")}
    it { should have_field("Email")}
    it { should have_field("Password")}
    it { should have_field("Confirm Password")}
    
    let(:submit) { "Create Account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.to_not change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First Name", with: "Michael"
        fill_in "Last Name", with: "Kelly"
        fill_in "Email", with: "michaelkelly322@gmail.com"
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "michaelkelly322@gmail.com") }
        
        it { should have_link('Logout') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end

