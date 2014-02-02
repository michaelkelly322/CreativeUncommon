require 'spec_helper'

describe "User pages", type: :feature do
  subject { page }
  
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
    end
  end
end

