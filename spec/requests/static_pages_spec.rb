require 'spec_helper'

describe "Site pages" do
  subject { page }
  
  describe "navigation" do
    before { visit root_path }
    it { should have_link("Home", href: root_path)}
    it { should have_link("User Guide", href: guide_path)}
    it { should have_link("FAQ", href: faq_path)}
    it { should have_link("About Us", href: about_path)}
    it { should have_link("Login", href: login_path)}
    it { should have_link("Signup", href: signup_path)}
  end
  
  describe "Home" do
    before { visit root_path }
    it { should have_title("Home")}
  end
  
  describe "FAQ" do
    before { visit faq_path }
    it { should have_title("FAQ")}
    
    it { should have_content("FAQ")}
  end
  
  describe "About Us" do
    before { visit about_path }
    it { should have_title("About Us")}
  end
  
  describe "User Guide" do
    before { visit guide_path }
    it { should have_title("User's Guide")}
    
    it { should have_content("User's Guide")}
  end
end
