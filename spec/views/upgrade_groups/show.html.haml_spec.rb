require 'spec_helper'

describe "upgrade_groups/show.html.haml" do
  before(:each) do
    @upgrade_group = assign(:upgrade_group, stub_model(UpgradeGroup,
      :name => "Name",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
