require "spec_helper"

describe SetupGroupsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/setup_groups" }.should route_to(:controller => "setup_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/setup_groups/new" }.should route_to(:controller => "setup_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/setup_groups/1" }.should route_to(:controller => "setup_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/setup_groups/1/edit" }.should route_to(:controller => "setup_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/setup_groups" }.should route_to(:controller => "setup_groups", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/setup_groups/1" }.should route_to(:controller => "setup_groups", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/setup_groups/1" }.should route_to(:controller => "setup_groups", :action => "destroy", :id => "1")
    end

  end
end
