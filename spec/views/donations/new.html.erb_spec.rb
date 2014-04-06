require 'spec_helper'

describe "donations/new" do
  before(:each) do
    assign(:donation, stub_model(Donation,
      :amount => "9.99",
      :site_donation => false,
      :approved => false
    ).as_new_record)
  end

  it "renders new donation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", donations_path, "post" do
      assert_select "input#donation_amount[name=?]", "donation[amount]"
      assert_select "input#donation_site_donation[name=?]", "donation[site_donation]"
      assert_select "input#donation_approved[name=?]", "donation[approved]"
    end
  end
end
