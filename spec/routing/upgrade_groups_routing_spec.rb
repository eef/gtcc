require "spec_helper"

describe UpgradeGroupsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/upgrade_groups" }.should route_to(:controller => "upgrade_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/upgrade_groups/new" }.should route_to(:controller => "upgrade_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/upgrade_groups/1" }.should route_to(:controller => "upgrade_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/upgrade_groups/1/edit" }.should route_to(:controller => "upgrade_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/upgrade_groups" }.should route_to(:controller => "upgrade_groups", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/upgrade_groups/1" }.should route_to(:controller => "upgrade_groups", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/upgrade_groups/1" }.should route_to(:controller => "upgrade_groups", :action => "destroy", :id => "1")
    end

  end
end
