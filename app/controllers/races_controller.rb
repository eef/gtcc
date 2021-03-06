class RacesController < ApplicationController
  # GET /races
  # GET /races.xml
  def index
    @open_races = Race.open_races
    @closed_races = Race.closed_races
    @my_races = current_user.my_races
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @races }
    end
  end

  # GET /races/1
  # GET /races/1.xml
  def show
    @race = Race.find(params[:id])
    @regulations = @race.race_regulations.first
    @event_settings = @race.event_settings.first
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @race }
    end
  end

  # GET /races/new
  # GET /races/new.xml
  def new
    @race = Race.new
    @race.photos.build
    unless params[:league_id]
      @race.race_regulations.build
      @race.event_settings.build
    else
      @league = League.find(params[:league_id])
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @race }
    end
  end

  # GET /races/1/edit
  def edit
    @race = Race.where(:id => params[:id], :organiser_id => current_user.id).first
    unless @race.league.blank?
      @league = League.find(@race.league_id)
      @users = @league.league_entries
    end
  end
  
  def generate_results
    @race = Race.where(:id => params[:id], :organiser_id => current_user.id).first
    respond_to do |format|
      if @race.league.blank?
      elsif !@race.league.blank?
        if @race.league.car_classes.length > 0
          format.html  { render :partial => "edit_result", :locals => {:league => @race.league} }
        else
          format.html  { render :partial => "edit_result", :locals => {:race => @race, :users => @race.league.users, :league => nil} }
        end
      end
    end
  end

  # POST /races
  # POST /races.xml
  def create
    @race = Race.new(params[:race])
    @race.organiser = current_user
    if params[:race][:league_id]
      redir = League.find(params[:race][:league_id])
    else
      redir = @race
    end
    respond_to do |format|
      if @race.save
        format.html { redirect_to(redir, :notice => 'Race was successfully created.') }
        format.xml  { render :xml => @race, :status => :created, :location => @race }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def enter_race
    @race = Race.find(params[:id])
    added = false
    if @race.users.length < @race.max_players
      @race.users << current_user
      added = true
    end
    respond_to do |format|
      if added
        if @race.save
          format.html { redirect_to(@race, :notice => 'You have entered the race.') }
          format.xml  { render :xml => @race, :status => :created, :location => @race }
        else
          format.html { redirect_to(@race, :notice => 'Unable to enter race.') }
          format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
        end
      else
        format.html { redirect_to(@race, :notice => 'No more places left on race.') }
      end
    end
  end
  
  def exit_race
    @race = Race.find(params[:id])
    if params[:user_id] and params[:id] and @race.organiser.eql?(current_user)
      temp_user = User.find(params[:user_id])
      @race.users.delete(temp_user)
      f_notice = "Removed #{temp_user.username}(#{temp_user.psn_name})"
    else
      @race.users.delete(current_user)
      f_notice = 'You have exited the race.'
    end
    respond_to do |format|
      if @race.save
        format.html { redirect_to(@race, :notice => f_notice) }
        format.xml  { render :xml => @race, :status => :created, :location => @race }
      else
        format.html { redirect_to(@race, :notice => 'Unable to exit race.') }
        format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /races/1
  # PUT /races/1.xml
  def update
    @race = Race.where(:id => params[:id], :organiser_id => current_user.id).first
    respond_to do |format|
      if @race.update_attributes(params[:race])
        format.html { redirect_to(@race, :notice => 'Race was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.xml
  def destroy
    @race = Race.where(:id => params[:id], :organiser_id => current_user.id).first
    @race.destroy
    respond_to do |format|
      format.html { redirect_to(races_url) }
      format.xml  { head :ok }
    end
  end
end
