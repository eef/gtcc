require "spec_helper"

describe UpgradesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/upgrades" }.should route_to(:controller => "upgrades", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/upgrades/new" }.should route_to(:controller => "upgrades", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/upgrades/1" }.should route_to(:controller => "upgrades", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/upgrades/1/edit" }.should route_to(:controller => "upgrades", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/upgrades" }.should route_to(:controller => "upgrades", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/upgrades/1" }.should route_to(:controller => "upgrades", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/upgrades/1" }.should route_to(:controller => "upgrades", :action => "destroy", :id => "1")
    end

  end
end
