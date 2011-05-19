require 'spec_helper'

describe "track_types/show.html.haml" do
  before(:each) do
    @track_type = assign(:track_type, stub_model(TrackType,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
