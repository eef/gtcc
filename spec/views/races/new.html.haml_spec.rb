require 'spec_helper'

describe "races/new.html.haml" do
  before(:each) do
    assign(:race, stub_model(Race,
      :name => "MyString",
      :location => nil,
      :track => nil
    ).as_new_record)
  end

  it "renders new race form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => races_path, :method => "post" do
      assert_select "input#race_name", :name => "race[name]"
      assert_select "input#race_location", :name => "race[location]"
      assert_select "input#race_track", :name => "race[track]"
    end
  end
end
