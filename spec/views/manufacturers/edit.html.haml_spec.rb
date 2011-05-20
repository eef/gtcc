require 'spec_helper'

describe "manufacturers/edit.html.haml" do
  before(:each) do
    @manufacturer = assign(:manufacturer, stub_model(Manufacturer,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit manufacturer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => manufacturer_path(@manufacturer), :method => "post" do
      assert_select "input#manufacturer_name", :name => "manufacturer[name]"
      assert_select "textarea#manufacturer_description", :name => "manufacturer[description]"
    end
  end
end
