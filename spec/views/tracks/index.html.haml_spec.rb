require 'spec_helper'

describe "tracks/index.html.haml" do
  before(:each) do
    assign(:tracks, [
      stub_model(Track,
        :name => "Name",
        :description => "MyText",
        :location => nil,
        :track_type => nil
      ),
      stub_model(Track,
        :name => "Name",
        :description => "MyText",
        :location => nil,
        :track_type => nil
      )
    ])
  end

  it "renders a list of tracks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
