require 'spec_helper'

describe "setup_groups/edit.html.haml" do
  before(:each) do
    @setup_group = assign(:setup_group, stub_model(SetupGroup,
      :name => "MyString",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ))
  end

  it "renders the edit setup_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => setup_group_path(@setup_group), :method => "post" do
      assert_select "input#setup_group_name", :name => "setup_group[name]"
      assert_select "input#setup_group_parent_id", :name => "setup_group[parent_id]"
      assert_select "input#setup_group_lft", :name => "setup_group[lft]"
      assert_select "input#setup_group_rgt", :name => "setup_group[rgt]"
    end
  end
end
