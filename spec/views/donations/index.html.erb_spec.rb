require 'spec_helper'

describe "donations/index" do
  before(:each) do
    assign(:donations, [
      stub_model(Donation,
        :amount => "9.99",
        :site_donation => false,
        :approved => false
      ),
      stub_model(Donation,
        :amount => "9.99",
        :site_donation => false,
        :approved => false
      )
    ])
  end

  it "renders a list of donations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
