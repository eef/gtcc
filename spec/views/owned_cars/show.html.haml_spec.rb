require 'spec_helper'

describe "owned_cars/show.html.haml" do
  before(:each) do
    @owned_car = assign(:owned_car, stub_model(OwnedCar,
      :nickname => "Nickname",
      :car_id => 1,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nickname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
