require "spec_helper"

describe CarsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/cars" }.should route_to(:controller => "cars", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cars/new" }.should route_to(:controller => "cars", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cars/1" }.should route_to(:controller => "cars", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cars/1/edit" }.should route_to(:controller => "cars", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cars" }.should route_to(:controller => "cars", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cars/1" }.should route_to(:controller => "cars", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cars/1" }.should route_to(:controller => "cars", :action => "destroy", :id => "1")
    end

  end
end
