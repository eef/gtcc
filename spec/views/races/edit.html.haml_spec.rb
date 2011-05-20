require 'spec_helper'

describe "races/edit.html.haml" do
  before(:each) do
    @race = assign(:race, stub_model(Race,
      :name => "MyString",
      :location => nil,
      :track => nil
    ))
  end

  it "renders the edit race form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => race_path(@race), :method => "post" do
      assert_select "input#race_name", :name => "race[name]"
      assert_select "input#race_location", :name => "race[location]"
      assert_select "input#race_track", :name => "race[track]"
    end
  end
end
