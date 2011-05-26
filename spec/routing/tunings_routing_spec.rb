require "spec_helper"

describe TuningsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tunings" }.should route_to(:controller => "tunings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tunings/new" }.should route_to(:controller => "tunings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tunings/1" }.should route_to(:controller => "tunings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tunings/1/edit" }.should route_to(:controller => "tunings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tunings" }.should route_to(:controller => "tunings", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tunings/1" }.should route_to(:controller => "tunings", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tunings/1" }.should route_to(:controller => "tunings", :action => "destroy", :id => "1")
    end

  end
end
