require 'spec_helper'

describe "setting_types/show.html.haml" do
  before(:each) do
    @setting_type = assign(:setting_type, stub_model(SettingType,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
