require 'spec_helper'

describe "cars/new.html.haml" do
  before(:each) do
    assign(:car, stub_model(Car,
      :name => "MyString",
      :manufacturer => nil
    ).as_new_record)
  end

  it "renders new car form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cars_path, :method => "post" do
      assert_select "input#car_name", :name => "car[name]"
      assert_select "input#car_manufacturer", :name => "car[manufacturer]"
    end
  end
end
