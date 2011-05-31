class SetupGroupsController < ApplicationController
  # GET /setup_groups
  # GET /setup_groups.xml
  def index
    @setup_groups = SetupGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setup_groups }
    end
  end

  # GET /setup_groups/1
  # GET /setup_groups/1.xml
  def show
    @setup_group = SetupGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setup_group }
    end
  end

  # GET /setup_groups/new
  # GET /setup_groups/new.xml
  def new
    @setup_group = SetupGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setup_group }
    end
  end

  # GET /setup_groups/1/edit
  def edit
    @setup_group = SetupGroup.find(params[:id])
  end

  # POST /setup_groups
  # POST /setup_groups.xml
  def create
    @setup_group = SetupGroup.new(params[:setup_group])

    respond_to do |format|
      if @setup_group.save
        format.html { redirect_to(@setup_group, :notice => 'Setup group was successfully created.') }
        format.xml  { render :xml => @setup_group, :status => :created, :location => @setup_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setup_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /setup_groups/1
  # PUT /setup_groups/1.xml
  def update
    @setup_group = SetupGroup.find(params[:id])

    respond_to do |format|
      if @setup_group.update_attributes(params[:setup_group])
        format.html { redirect_to(@setup_group, :notice => 'Setup group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setup_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /setup_groups/1
  # DELETE /setup_groups/1.xml
  def destroy
    @setup_group = SetupGroup.find(params[:id])
    @setup_group.destroy

    respond_to do |format|
      format.html { redirect_to(setup_groups_url) }
      format.xml  { head :ok }
    end
  end
end
