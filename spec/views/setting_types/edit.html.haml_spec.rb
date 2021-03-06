require 'spec_helper'

describe "setting_types/edit.html.haml" do
  before(:each) do
    @setting_type = assign(:setting_type, stub_model(SettingType,
      :name => "MyString"
    ))
  end

  it "renders the edit setting_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => setting_type_path(@setting_type), :method => "post" do
      assert_select "input#setting_type_name", :name => "setting_type[name]"
    end
  end
end
