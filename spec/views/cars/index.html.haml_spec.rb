require 'spec_helper'

describe "cars/index.html.haml" do
  before(:each) do
    assign(:cars, [
      stub_model(Car,
        :name => "Name",
        :manufacturer => nil
      ),
      stub_model(Car,
        :name => "Name",
        :manufacturer => nil
      )
    ])
  end

  it "renders a list of cars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
