require "spec_helper"

describe SettingTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/setting_types" }.should route_to(:controller => "setting_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/setting_types/new" }.should route_to(:controller => "setting_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/setting_types/1" }.should route_to(:controller => "setting_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/setting_types/1/edit" }.should route_to(:controller => "setting_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/setting_types" }.should route_to(:controller => "setting_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/setting_types/1" }.should route_to(:controller => "setting_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/setting_types/1" }.should route_to(:controller => "setting_types", :action => "destroy", :id => "1")
    end

  end
end
