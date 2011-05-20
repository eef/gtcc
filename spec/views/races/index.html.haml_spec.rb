require 'spec_helper'

describe "races/index.html.haml" do
  before(:each) do
    assign(:races, [
      stub_model(Race,
        :name => "Name",
        :location => nil,
        :track => nil
      ),
      stub_model(Race,
        :name => "Name",
        :location => nil,
        :track => nil
      )
    ])
  end

  it "renders a list of races" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
