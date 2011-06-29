require 'spec_helper'

describe "leagues/new.html.haml" do
  before(:each) do
    assign(:league, stub_model(League,
      :name => "MyString",
      :max_players => 1,
      :organiser_id => 1
    ).as_new_record)
  end

  it "renders new league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => leagues_path, :method => "post" do
      assert_select "input#league_name", :name => "league[name]"
      assert_select "input#league_max_players", :name => "league[max_players]"
      assert_select "input#league_organiser_id", :name => "league[organiser_id]"
    end
  end
end
