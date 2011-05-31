require 'spec_helper'

describe "setting_types/new.html.haml" do
  before(:each) do
    assign(:setting_type, stub_model(SettingType,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new setting_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => setting_types_path, :method => "post" do
      assert_select "input#setting_type_name", :name => "setting_type[name]"
    end
  end
end
