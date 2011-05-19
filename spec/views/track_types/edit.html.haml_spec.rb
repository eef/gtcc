require 'spec_helper'

describe "track_types/edit.html.haml" do
  before(:each) do
    @track_type = assign(:track_type, stub_model(TrackType,
      :name => "MyString"
    ))
  end

  it "renders the edit track_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => track_type_path(@track_type), :method => "post" do
      assert_select "input#track_type_name", :name => "track_type[name]"
    end
  end
end
