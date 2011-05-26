class OwnedCarsController < ApplicationController
  # GET /owned_cars
  # GET /owned_cars.xml
  def index
    @owned_cars = OwnedCar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @owned_cars }
    end
  end

  # GET /owned_cars/1
  # GET /owned_cars/1.xml
  def show
    @owned_car = OwnedCar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @owned_car }
    end
  end

  # GET /owned_cars/new
  # GET /owned_cars/new.xml
  def new
    @owned_car = OwnedCar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @owned_car }
    end
  end

  # GET /owned_cars/1/edit
  def edit
    @owned_car = OwnedCar.find(params[:id])
  end

  # POST /owned_cars
  # POST /owned_cars.xml
  def create
    @owned_car = OwnedCar.new(params[:owned_car])

    respond_to do |format|
      if @owned_car.save
        format.html { redirect_to(@owned_car, :notice => 'Owned car was successfully created.') }
        format.xml  { render :xml => @owned_car, :status => :created, :location => @owned_car }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @owned_car.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /owned_cars/1
  # PUT /owned_cars/1.xml
  def update
    @owned_car = OwnedCar.find(params[:id])

    respond_to do |format|
      if @owned_car.update_attributes(params[:owned_car])
        format.html { redirect_to(@owned_car, :notice => 'Owned car was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @owned_car.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /owned_cars/1
  # DELETE /owned_cars/1.xml
  def destroy
    @owned_car = OwnedCar.find(params[:id])
    @owned_car.destroy

    respond_to do |format|
      format.html { redirect_to(owned_cars_url) }
      format.xml  { head :ok }
    end
  end
end
