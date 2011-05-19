class TrackTypesController < ApplicationController
  # GET /track_types
  # GET /track_types.xml
  def index
    @track_types = TrackType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @track_types }
    end
  end

  # GET /track_types/1
  # GET /track_types/1.xml
  def show
    @track_type = TrackType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track_type }
    end
  end

  # GET /track_types/new
  # GET /track_types/new.xml
  def new
    @track_type = TrackType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @track_type }
    end
  end

  # GET /track_types/1/edit
  def edit
    @track_type = TrackType.find(params[:id])
  end

  # POST /track_types
  # POST /track_types.xml
  def create
    @track_type = TrackType.new(params[:track_type])

    respond_to do |format|
      if @track_type.save
        format.html { redirect_to(@track_type, :notice => 'Track type was successfully created.') }
        format.xml  { render :xml => @track_type, :status => :created, :location => @track_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @track_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /track_types/1
  # PUT /track_types/1.xml
  def update
    @track_type = TrackType.find(params[:id])

    respond_to do |format|
      if @track_type.update_attributes(params[:track_type])
        format.html { redirect_to(@track_type, :notice => 'Track type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /track_types/1
  # DELETE /track_types/1.xml
  def destroy
    @track_type = TrackType.find(params[:id])
    @track_type.destroy

    respond_to do |format|
      format.html { redirect_to(track_types_url) }
      format.xml  { head :ok }
    end
  end
end
