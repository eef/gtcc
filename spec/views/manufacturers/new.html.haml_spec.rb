require 'spec_helper'

describe "manufacturers/new.html.haml" do
  before(:each) do
    assign(:manufacturer, stub_model(Manufacturer,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new manufacturer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => manufacturers_path, :method => "post" do
      assert_select "input#manufacturer_name", :name => "manufacturer[name]"
      assert_select "textarea#manufacturer_description", :name => "manufacturer[description]"
    end
  end
end
