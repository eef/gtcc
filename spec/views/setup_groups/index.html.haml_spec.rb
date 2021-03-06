require 'spec_helper'

describe "setup_groups/index.html.haml" do
  before(:each) do
    assign(:setup_groups, [
      stub_model(SetupGroup,
        :name => "Name",
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      ),
      stub_model(SetupGroup,
        :name => "Name",
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      )
    ])
  end

  it "renders a list of setup_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
