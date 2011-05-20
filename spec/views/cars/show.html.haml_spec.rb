require 'spec_helper'

describe "cars/show.html.haml" do
  before(:each) do
    @car = assign(:car, stub_model(Car,
      :name => "Name",
      :manufacturer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
