require "spec_helper"

describe OwnedCarsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/owned_cars" }.should route_to(:controller => "owned_cars", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/owned_cars/new" }.should route_to(:controller => "owned_cars", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/owned_cars/1" }.should route_to(:controller => "owned_cars", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/owned_cars/1/edit" }.should route_to(:controller => "owned_cars", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/owned_cars" }.should route_to(:controller => "owned_cars", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/owned_cars/1" }.should route_to(:controller => "owned_cars", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/owned_cars/1" }.should route_to(:controller => "owned_cars", :action => "destroy", :id => "1")
    end

  end
end
