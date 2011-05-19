require 'spec_helper'

describe "starbases/edit.html.haml" do
  before(:each) do
    @starbase = assign(:starbase, stub_model(Starbase,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit starbase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => starbase_path(@starbase), :method => "post" do
      assert_select "input#starbase_name", :name => "starbase[name]"
      assert_select "textarea#starbase_description", :name => "starbase[description]"
    end
  end
end
