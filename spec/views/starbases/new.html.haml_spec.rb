require 'spec_helper'

describe "starbases/new.html.haml" do
  before(:each) do
    assign(:starbase, stub_model(Starbase,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new starbase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => starbases_path, :method => "post" do
      assert_select "input#starbase_name", :name => "starbase[name]"
      assert_select "textarea#starbase_description", :name => "starbase[description]"
    end
  end
end
