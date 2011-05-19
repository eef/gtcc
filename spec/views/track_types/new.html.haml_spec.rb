require 'spec_helper'

describe "track_types/new.html.haml" do
  before(:each) do
    assign(:track_type, stub_model(TrackType,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new track_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => track_types_path, :method => "post" do
      assert_select "input#track_type_name", :name => "track_type[name]"
    end
  end
end
