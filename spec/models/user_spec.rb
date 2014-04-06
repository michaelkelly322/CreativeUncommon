require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Michael",
                            last_name: "Kelly",
                            email: "michaelkelly322@gmail.com",
                            password: "password1",
                            password_confirmation: "password1")}
  
  subject {@user}
  
  # Basic User Attributes
  it { should respond_to(:first_name)}
  it { should respond_to(:last_name)}
  it { should respond_to(:email)}
  it { should respond_to(:email_confirmation)}
  it { should respond_to(:bio)}
  it { should respond_to(:username)}
  it { should respond_to(:works)}
  
  # Authentication Attrs
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:session_key) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid}
  
  # => Email attribute validations
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com man_at_foo_org shit+fuck@redcom]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com man@foo.org shit.fuck@red.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  # => Name Attributes
  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end
  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end
  describe "when first name is too long" do
    before { @user.first_name = "x" * 51 }
    it { should_not be_valid }
  end
  describe "when last name is too long" do
    before { @user.last_name = "x" * 51 }
    it { should_not be_valid }
  end
  
  # => Secure Password Attributes
  describe "when password is not present" do
    before do
      @user = User.new(first_name: "firstname", last_name: "lastname",
                       email: "xxx@xxx.com", password: " ", password_confirmation: " ")
    end
    
    it { should_not be_valid }
  end
  
  describe "when password and password_confirmation don't match" do
    before do
      @user = User.new(first_name: "firstname", last_name: "lastname",
                       email: "xxx@xxx.com", password: "pass", password_confirmation: "word")
    end
    
    it { should_not be_valid }
  end
  
  # => Authentication
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  
  describe "when password is too short" do
    before { @user.password_confirmation = @user.password = "a" * 7 }
    it { should_not be_valid }
  end
  
  describe "when password doesn't contain a number" do
    before { @user.password_confirmation = @user.password = "a" * 8 }
    it { should_not be_valid }
  end
  
  describe "when password doesn't contain a alpha" do
    before { @user.password_confirmation = @user.password = "2" * 8 }
    it { should_not be_valid }
  end
  
  describe "session key" do
    before { @user.save }
    its(:session_key) { should_not be_blank }
  end
end 
