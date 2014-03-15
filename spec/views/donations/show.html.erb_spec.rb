require 'spec_helper'

describe "donations/show" do
  before(:each) do
    @donation = assign(:donation, stub_model(Donation,
      :amount => "9.99",
      :site_donation => false,
      :approved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
