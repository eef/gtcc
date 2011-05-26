class UpgradeGroupsController < ApplicationController
  # GET /upgrade_groups
  # GET /upgrade_groups.xml
  def index
    @upgrade_groups = UpgradeGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @upgrade_groups }
    end
  end

  # GET /upgrade_groups/1
  # GET /upgrade_groups/1.xml
  def show
    @upgrade_group = UpgradeGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upgrade_group }
    end
  end

  # GET /upgrade_groups/new
  # GET /upgrade_groups/new.xml
  def new
    @upgrade_group = UpgradeGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upgrade_group }
    end
  end

  # GET /upgrade_groups/1/edit
  def edit
    @upgrade_group = UpgradeGroup.find(params[:id])
  end

  # POST /upgrade_groups
  # POST /upgrade_groups.xml
  def create
    @upgrade_group = UpgradeGroup.new(params[:upgrade_group])

    respond_to do |format|
      if @upgrade_group.save
        format.html { redirect_to(@upgrade_group, :notice => 'Upgrade group was successfully created.') }
        format.xml  { render :xml => @upgrade_group, :status => :created, :location => @upgrade_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upgrade_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /upgrade_groups/1
  # PUT /upgrade_groups/1.xml
  def update
    @upgrade_group = UpgradeGroup.find(params[:id])

    respond_to do |format|
      if @upgrade_group.update_attributes(params[:upgrade_group])
        format.html { redirect_to(@upgrade_group, :notice => 'Upgrade group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upgrade_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /upgrade_groups/1
  # DELETE /upgrade_groups/1.xml
  def destroy
    @upgrade_group = UpgradeGroup.find(params[:id])
    @upgrade_group.destroy

    respond_to do |format|
      format.html { redirect_to(upgrade_groups_url) }
      format.xml  { head :ok }
    end
  end
end
