require 'spec_helper'

describe "cars/edit.html.haml" do
  before(:each) do
    @car = assign(:car, stub_model(Car,
      :name => "MyString",
      :manufacturer => nil
    ))
  end

  it "renders the edit car form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => car_path(@car), :method => "post" do
      assert_select "input#car_name", :name => "car[name]"
      assert_select "input#car_manufacturer", :name => "car[manufacturer]"
    end
  end
end
