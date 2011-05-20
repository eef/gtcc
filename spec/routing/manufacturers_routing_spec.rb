require "spec_helper"

describe ManufacturersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/manufacturers" }.should route_to(:controller => "manufacturers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/manufacturers/new" }.should route_to(:controller => "manufacturers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/manufacturers/1" }.should route_to(:controller => "manufacturers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/manufacturers/1/edit" }.should route_to(:controller => "manufacturers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/manufacturers" }.should route_to(:controller => "manufacturers", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/manufacturers/1" }.should route_to(:controller => "manufacturers", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/manufacturers/1" }.should route_to(:controller => "manufacturers", :action => "destroy", :id => "1")
    end

  end
end
