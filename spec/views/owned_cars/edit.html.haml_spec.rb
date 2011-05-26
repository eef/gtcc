require 'spec_helper'

describe "owned_cars/edit.html.haml" do
  before(:each) do
    @owned_car = assign(:owned_car, stub_model(OwnedCar,
      :nickname => "MyString",
      :car_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit owned_car form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => owned_car_path(@owned_car), :method => "post" do
      assert_select "input#owned_car_nickname", :name => "owned_car[nickname]"
      assert_select "input#owned_car_car_id", :name => "owned_car[car_id]"
      assert_select "input#owned_car_user_id", :name => "owned_car[user_id]"
    end
  end
end
