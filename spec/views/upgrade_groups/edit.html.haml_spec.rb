require 'spec_helper'

describe "upgrade_groups/edit.html.haml" do
  before(:each) do
    @upgrade_group = assign(:upgrade_group, stub_model(UpgradeGroup,
      :name => "MyString",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ))
  end

  it "renders the edit upgrade_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => upgrade_group_path(@upgrade_group), :method => "post" do
      assert_select "input#upgrade_group_name", :name => "upgrade_group[name]"
      assert_select "input#upgrade_group_parent_id", :name => "upgrade_group[parent_id]"
      assert_select "input#upgrade_group_lft", :name => "upgrade_group[lft]"
      assert_select "input#upgrade_group_rgt", :name => "upgrade_group[rgt]"
    end
  end
end
