class LeaguesController < ApplicationController
  # GET /leagues
  # GET /leagues.xml
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @league = League.find(params[:id])
    @regulations = @league.race_regulations.first
    @event_settings = @league.event_settings.first
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @league = League.new
    @league.race_regulations.build
    @league.event_settings.build
    16.times { @league.league_points.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @league = League.new(params[:league])
    @league.organiser = current_user
    @league.users << current_user
    respond_to do |format|
      if @league.save
        format.html { redirect_to(@league, :notice => 'League was successfully created.') }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def enter_league
    @league = League.find(params[:id])
    added = false
    if @league.users.length < @league.max_players
      @league.users << current_user
      added = true
    end
    respond_to do |format|
      if added
        if @league.save
          format.html { redirect_to(@league, :notice => 'You have entered the league.') }
          format.xml  { render :xml => @league, :status => :created, :location => @league }
        else
          format.html { redirect_to(@league, :notice => 'Unable to enter race.') }
          format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
        end
      else
        format.html { redirect_to(@league, :notice => 'No more places left on league.') }
      end
    end
  end
  
  def exit_race
    @league = League.find(params[:id])
    if params[:user_id] and params[:id] and @league.organiser.eql?(current_user)
      temp_user = User.find(params[:user_id])
      @league.users.delete(temp_user)
      f_notice = "Removed #{temp_user.username}(#{temp_user.psn_name})"
    else
      @league.users.delete(current_user)
      f_notice = 'You have exited the league.'
    end
    respond_to do |format|
      if @league.save
        format.html { redirect_to("/leagues/#{@league.id}#register", :notice => f_notice) }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { redirect_to(@league, :notice => 'Unable to exit race.') }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to(@league, :notice => 'League was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.xml
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to(leagues_url) }
      format.xml  { head :ok }
    end
  end
end
