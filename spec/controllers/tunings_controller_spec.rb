require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe TuningsController do

  def mock_tuning(stubs={})
    @mock_tuning ||= mock_model(Tuning, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tunings as @tunings" do
      Tuning.stub(:all) { [mock_tuning] }
      get :index
      assigns(:tunings).should eq([mock_tuning])
    end
  end

  describe "GET show" do
    it "assigns the requested tuning as @tuning" do
      Tuning.stub(:find).with("37") { mock_tuning }
      get :show, :id => "37"
      assigns(:tuning).should be(mock_tuning)
    end
  end

  describe "GET new" do
    it "assigns a new tuning as @tuning" do
      Tuning.stub(:new) { mock_tuning }
      get :new
      assigns(:tuning).should be(mock_tuning)
    end
  end

  describe "GET edit" do
    it "assigns the requested tuning as @tuning" do
      Tuning.stub(:find).with("37") { mock_tuning }
      get :edit, :id => "37"
      assigns(:tuning).should be(mock_tuning)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created tuning as @tuning" do
        Tuning.stub(:new).with({'these' => 'params'}) { mock_tuning(:save => true) }
        post :create, :tuning => {'these' => 'params'}
        assigns(:tuning).should be(mock_tuning)
      end

      it "redirects to the created tuning" do
        Tuning.stub(:new) { mock_tuning(:save => true) }
        post :create, :tuning => {}
        response.should redirect_to(tuning_url(mock_tuning))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tuning as @tuning" do
        Tuning.stub(:new).with({'these' => 'params'}) { mock_tuning(:save => false) }
        post :create, :tuning => {'these' => 'params'}
        assigns(:tuning).should be(mock_tuning)
      end

      it "re-renders the 'new' template" do
        Tuning.stub(:new) { mock_tuning(:save => false) }
        post :create, :tuning => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tuning" do
        Tuning.stub(:find).with("37") { mock_tuning }
        mock_tuning.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tuning => {'these' => 'params'}
      end

      it "assigns the requested tuning as @tuning" do
        Tuning.stub(:find) { mock_tuning(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tuning).should be(mock_tuning)
      end

      it "redirects to the tuning" do
        Tuning.stub(:find) { mock_tuning(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tuning_url(mock_tuning))
      end
    end

    describe "with invalid params" do
      it "assigns the tuning as @tuning" do
        Tuning.stub(:find) { mock_tuning(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tuning).should be(mock_tuning)
      end

      it "re-renders the 'edit' template" do
        Tuning.stub(:find) { mock_tuning(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tuning" do
      Tuning.stub(:find).with("37") { mock_tuning }
      mock_tuning.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tunings list" do
      Tuning.stub(:find) { mock_tuning }
      delete :destroy, :id => "1"
      response.should redirect_to(tunings_url)
    end
  end

end
