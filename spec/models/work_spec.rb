require 'spec_helper'

describe Work do
  let(:user) { FactoryGirl.create(:user) }
  before { @work = user.works.build(blurb: "blurb",
                                    title: "Title",
                                    author_name: "author man!",
                                    body: "Lorem Ipsum",
                                    mature: false,
                                    draft: true)}
                                    
  subject { @work }
  
  it { should respond_to(:blurb)}
  it { should respond_to(:title)}
  it { should respond_to(:author_name)}
  it { should respond_to(:body)}
  it { should respond_to(:mature)}
  it { should respond_to(:draft)}
  it { should respond_to(:user)}
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user id is not present" do
    before { @work.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when title is not present" do
    before { @work.title = nil }
    it { should_not be_valid }
  end
end