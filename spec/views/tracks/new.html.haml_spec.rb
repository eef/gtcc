require 'spec_helper'

describe "tracks/new.html.haml" do
  before(:each) do
    assign(:track, stub_model(Track,
      :name => "MyString",
      :description => "MyText",
      :location => nil,
      :track_type => nil
    ).as_new_record)
  end

  it "renders new track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tracks_path, :method => "post" do
      assert_select "input#track_name", :name => "track[name]"
      assert_select "textarea#track_description", :name => "track[description]"
      assert_select "input#track_location", :name => "track[location]"
      assert_select "input#track_track_type", :name => "track[track_type]"
    end
  end
end
