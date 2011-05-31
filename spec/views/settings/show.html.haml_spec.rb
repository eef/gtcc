require 'spec_helper'

describe "settings/show.html.haml" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
      :value => "Value",
      :setup_group_id => 1,
      :tuning_id => 1,
      :setting_type_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
