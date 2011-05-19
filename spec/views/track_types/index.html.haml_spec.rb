require 'spec_helper'

describe "track_types/index.html.haml" do
  before(:each) do
    assign(:track_types, [
      stub_model(TrackType,
        :name => "Name"
      ),
      stub_model(TrackType,
        :name => "Name"
      )
    ])
  end

  it "renders a list of track_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
