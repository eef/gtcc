require 'spec_helper'

describe "upgrades/index.html.haml" do
  before(:each) do
    assign(:upgrades, [
      stub_model(Upgrade,
        :name => "Name",
        :upgrade_group_id => 1,
        :description => "MyText"
      ),
      stub_model(Upgrade,
        :name => "Name",
        :upgrade_group_id => 1,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of upgrades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
