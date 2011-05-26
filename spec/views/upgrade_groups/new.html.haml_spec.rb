require 'spec_helper'

describe "upgrade_groups/new.html.haml" do
  before(:each) do
    assign(:upgrade_group, stub_model(UpgradeGroup,
      :name => "MyString",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ).as_new_record)
  end

  it "renders new upgrade_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => upgrade_groups_path, :method => "post" do
      assert_select "input#upgrade_group_name", :name => "upgrade_group[name]"
      assert_select "input#upgrade_group_parent_id", :name => "upgrade_group[parent_id]"
      assert_select "input#upgrade_group_lft", :name => "upgrade_group[lft]"
      assert_select "input#upgrade_group_rgt", :name => "upgrade_group[rgt]"
    end
  end
end
