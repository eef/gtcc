require 'spec_helper'

describe "leagues/edit.html.haml" do
  before(:each) do
    @league = assign(:league, stub_model(League,
      :name => "MyString",
      :max_players => 1,
      :organiser_id => 1
    ))
  end

  it "renders the edit league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => league_path(@league), :method => "post" do
      assert_select "input#league_name", :name => "league[name]"
      assert_select "input#league_max_players", :name => "league[max_players]"
      assert_select "input#league_organiser_id", :name => "league[organiser_id]"
    end
  end
end
