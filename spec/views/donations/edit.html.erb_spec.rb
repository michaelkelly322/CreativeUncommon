require 'spec_helper'

describe "donations/edit" do
  before(:each) do
    @donation = assign(:donation, stub_model(Donation,
      :amount => "9.99",
      :site_donation => false,
      :approved => false
    ))
  end

  it "renders the edit donation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", donation_path(@donation), "post" do
      assert_select "input#donation_amount[name=?]", "donation[amount]"
      assert_select "input#donation_site_donation[name=?]", "donation[site_donation]"
      assert_select "input#donation_approved[name=?]", "donation[approved]"
    end
  end
end
