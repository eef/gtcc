require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe LeaguesController do

  def mock_league(stubs={})
    @mock_league ||= mock_model(League, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all leagues as @leagues" do
      League.stub(:all) { [mock_league] }
      get :index
      assigns(:leagues).should eq([mock_league])
    end
  end

  describe "GET show" do
    it "assigns the requested league as @league" do
      League.stub(:find).with("37") { mock_league }
      get :show, :id => "37"
      assigns(:league).should be(mock_league)
    end
  end

  describe "GET new" do
    it "assigns a new league as @league" do
      League.stub(:new) { mock_league }
      get :new
      assigns(:league).should be(mock_league)
    end
  end

  describe "GET edit" do
    it "assigns the requested league as @league" do
      League.stub(:find).with("37") { mock_league }
      get :edit, :id => "37"
      assigns(:league).should be(mock_league)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created league as @league" do
        League.stub(:new).with({'these' => 'params'}) { mock_league(:save => true) }
        post :create, :league => {'these' => 'params'}
        assigns(:league).should be(mock_league)
      end

      it "redirects to the created league" do
        League.stub(:new) { mock_league(:save => true) }
        post :create, :league => {}
        response.should redirect_to(league_url(mock_league))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved league as @league" do
        League.stub(:new).with({'these' => 'params'}) { mock_league(:save => false) }
        post :create, :league => {'these' => 'params'}
        assigns(:league).should be(mock_league)
      end

      it "re-renders the 'new' template" do
        League.stub(:new) { mock_league(:save => false) }
        post :create, :league => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested league" do
        League.stub(:find).with("37") { mock_league }
        mock_league.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :league => {'these' => 'params'}
      end

      it "assigns the requested league as @league" do
        League.stub(:find) { mock_league(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:league).should be(mock_league)
      end

      it "redirects to the league" do
        League.stub(:find) { mock_league(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(league_url(mock_league))
      end
    end

    describe "with invalid params" do
      it "assigns the league as @league" do
        League.stub(:find) { mock_league(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:league).should be(mock_league)
      end

      it "re-renders the 'edit' template" do
        League.stub(:find) { mock_league(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested league" do
      League.stub(:find).with("37") { mock_league }
      mock_league.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the leagues list" do
      League.stub(:find) { mock_league }
      delete :destroy, :id => "1"
      response.should redirect_to(leagues_url)
    end
  end

end
