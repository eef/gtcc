require 'spec_helper'

describe "setup_groups/new.html.haml" do
  before(:each) do
    assign(:setup_group, stub_model(SetupGroup,
      :name => "MyString",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ).as_new_record)
  end

  it "renders new setup_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => setup_groups_path, :method => "post" do
      assert_select "input#setup_group_name", :name => "setup_group[name]"
      assert_select "input#setup_group_parent_id", :name => "setup_group[parent_id]"
      assert_select "input#setup_group_lft", :name => "setup_group[lft]"
      assert_select "input#setup_group_rgt", :name => "setup_group[rgt]"
    end
  end
end
