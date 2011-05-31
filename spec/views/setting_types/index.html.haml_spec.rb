require 'spec_helper'

describe "setting_types/index.html.haml" do
  before(:each) do
    assign(:setting_types, [
      stub_model(SettingType,
        :name => "Name"
      ),
      stub_model(SettingType,
        :name => "Name"
      )
    ])
  end

  it "renders a list of setting_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
