require "spec_helper"

describe TracksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tracks" }.should route_to(:controller => "tracks", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tracks/new" }.should route_to(:controller => "tracks", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tracks/1" }.should route_to(:controller => "tracks", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tracks/1/edit" }.should route_to(:controller => "tracks", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tracks" }.should route_to(:controller => "tracks", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tracks/1" }.should route_to(:controller => "tracks", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tracks/1" }.should route_to(:controller => "tracks", :action => "destroy", :id => "1")
    end

  end
end
