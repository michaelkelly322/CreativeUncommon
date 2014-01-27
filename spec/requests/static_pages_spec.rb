require 'spec_helper'

describe "Site pages" do
  subject { page }
  
  describe "Home" do
    before { visit root_path }
    it { should have_title("Home")}
  end
  
  describe "FAQ" do
    before { visit faq_path }
    it { should have_title("FAQ")}
  end
  
  describe "About Us" do
    before { visit about_path }
    it { should have_title("About Us")}
  end
  
  describe "User Guide" do
    before { visit guide_path }
    it { should have_title("User's Guide")}
  end
end
