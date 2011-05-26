require 'spec_helper'

describe "owned_cars/index.html.haml" do
  before(:each) do
    assign(:owned_cars, [
      stub_model(OwnedCar,
        :nickname => "Nickname",
        :car_id => 1,
        :user_id => 1
      ),
      stub_model(OwnedCar,
        :nickname => "Nickname",
        :car_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of owned_cars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
