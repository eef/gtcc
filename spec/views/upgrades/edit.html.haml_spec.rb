require 'spec_helper'

describe "upgrades/edit.html.haml" do
  before(:each) do
    @upgrade = assign(:upgrade, stub_model(Upgrade,
      :name => "MyString",
      :upgrade_group_id => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit upgrade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => upgrade_path(@upgrade), :method => "post" do
      assert_select "input#upgrade_name", :name => "upgrade[name]"
      assert_select "input#upgrade_upgrade_group_id", :name => "upgrade[upgrade_group_id]"
      assert_select "textarea#upgrade_description", :name => "upgrade[description]"
    end
  end
end
