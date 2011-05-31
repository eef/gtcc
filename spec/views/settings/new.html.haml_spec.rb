require 'spec_helper'

describe "settings/new.html.haml" do
  before(:each) do
    assign(:setting, stub_model(Setting,
      :value => "MyString",
      :setup_group_id => 1,
      :tuning_id => 1,
      :setting_type_id => 1
    ).as_new_record)
  end

  it "renders new setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => settings_path, :method => "post" do
      assert_select "input#setting_value", :name => "setting[value]"
      assert_select "input#setting_setup_group_id", :name => "setting[setup_group_id]"
      assert_select "input#setting_tuning_id", :name => "setting[tuning_id]"
      assert_select "input#setting_setting_type_id", :name => "setting[setting_type_id]"
    end
  end
end
