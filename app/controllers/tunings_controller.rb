class TuningsController < ApplicationController
  # GET /tunings
  # GET /tunings.xml
  def index
    if params[:id]
      @tunings = current_user.tunings.where(:car_id => params[:id]).all
    else
      t = Tuning.arel_table
      @tunings = Tuning.where(
                  t[:user_id].eq(current_user.id).or(t[:public].eq(true))
                )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tunings }
    end
  end

  # GET /tunings/1
  # GET /tunings/1.xml
  def show
    @tuning = Tuning.find(params[:id])

    respond_to do |format|
      if @tuning.user.eql?(current_user) or @tuning.public
        format.html # show.html.erb
        format.xml  { render :xml => @tuning }
      else
        format.html { redirect_to(tunings_path, :notice => "Can't be looking at that.") }
      end
    end
  end

  # GET /tunings/new
  # GET /tunings/new.xml
  def new
    @tuning = Tuning.new
    @cars = current_user.owned_cars
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tuning }
    end
  end

  # GET /tunings/1/edit
  def edit
    @tuning = current_user.tunings.find(params[:id])
    @cars = current_user.owned_cars
  end

  # POST /tunings
  # POST /tunings.xml
  def create
    @tuning = Tuning.new(params[:tuning])
    @tuning.user = current_user
    respond_to do |format|
      if @tuning.save
        format.html { redirect_to(@tuning, :notice => 'Tuning was successfully created.') }
        format.xml  { render :xml => @tuning, :status => :created, :location => @tuning }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tuning.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tunings/1
  # PUT /tunings/1.xml
  def update
    @tuning = Tuning.find(params[:id])
    params[:tuning][:upgrade_ids] ||= []
    respond_to do |format|
      if @tuning.update_attributes(params[:tuning])
        format.html { redirect_to(@tuning, :notice => 'Tuning was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tuning.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tunings/1
  # DELETE /tunings/1.xml
  def destroy
    @tuning = Tuning.find(params[:id])
    @tuning.destroy

    respond_to do |format|
      format.html { redirect_to(tunings_url) }
      format.xml  { head :ok }
    end
  end
end
