require "spec_helper"

describe TrackTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/track_types" }.should route_to(:controller => "track_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/track_types/new" }.should route_to(:controller => "track_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/track_types/1" }.should route_to(:controller => "track_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/track_types/1/edit" }.should route_to(:controller => "track_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/track_types" }.should route_to(:controller => "track_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/track_types/1" }.should route_to(:controller => "track_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/track_types/1" }.should route_to(:controller => "track_types", :action => "destroy", :id => "1")
    end

  end
end
