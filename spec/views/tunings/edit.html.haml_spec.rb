require 'spec_helper'

describe "tunings/edit.html.haml" do
  before(:each) do
    @tuning = assign(:tuning, stub_model(Tuning,
      :name => "MyString",
      :car_id => 1,
      :user_id => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit tuning form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tuning_path(@tuning), :method => "post" do
      assert_select "input#tuning_name", :name => "tuning[name]"
      assert_select "input#tuning_car_id", :name => "tuning[car_id]"
      assert_select "input#tuning_user_id", :name => "tuning[user_id]"
      assert_select "textarea#tuning_description", :name => "tuning[description]"
    end
  end
end
