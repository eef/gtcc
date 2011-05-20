require 'spec_helper'

describe "races/show.html.haml" do
  before(:each) do
    @race = assign(:race, stub_model(Race,
      :name => "Name",
      :location => nil,
      :track => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
