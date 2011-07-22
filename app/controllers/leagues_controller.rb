class LeaguesController < ApplicationController
  # GET /leagues
  # GET /leagues.xml
  def index
    @open_leagues = League.open_leagues
    @my_leagues = []
    @closed_leagues = League.closed_leagues
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
    @show_reg = false
    generate_entries
    if !@league.car_classes.blank?
      unless @league.league_entries.where(:user_id => current_user.id).length > 0
        @show_reg = true
        if @league.league_cars.blank? or @league.league_cars.where(:amount => nil).length > 0
          @classes = @league.car_classes
        else
          @classes = @league.car_classes
          @reg_cars = @league.league_cars.where("league_cars.used_amount < league_cars.amount").order("league_cars.car_class_id DESC").select {|cc| !cc.car_name.blank? or (!cc.amount.eql?(0) and !cc.car_name.blank?) } 
        end
      end
    elsif @league.league_cars.where("league_cars.amount > 0 AND league_cars.used_amount < league_cars.amount AND league_cars.car_class_id IS NULL").length > 0
      @reg_cars = @league.league_cars.where("league_cars.amount > 0 AND league_cars.used_amount < league_cars.amount AND league_cars.car_class_id IS NULL")
    end
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
    @league.league_points.build
    @league.car_classes.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = current_user.leagues.find(params[:id])
    @league.league_cars.build if @league.league_cars.blank?
    @league.league_points.build if @league.league_points.blank?
    @car_classes = @league.car_classes
    @show_table = false
    if @league.league_cars.where("league_cars.amount > 0").length > 0
      @show_table = true
    end
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @league = League.new(params[:league])
    @league.organiser = current_user
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
    if params[:car_name] and !params[:car_class_id].blank? and params[:car_id]
      logger.info "1"
      league_car = {:car_name => params[:car_name], :car_class_id => params[:car_class_id]}
    elsif params[:car_name] and params[:car_id]
      logger.info "2"
      league_car = [params[:car_name], params[:car_id]]
    else
      league_car = LeagueCar.find_by_id(params[:lc_id])
    end
    added = @league.register_driver(current_user, league_car)
    respond_to do |format|
      if added
        @show_reg = false
        @reg_cars = @league.league_cars.where("league_cars.car_class_id != NULL").order("league_cars.car_class_id DESC").select {|cc| !cc.car_name.blank? or (!cc.amount.eql?(0) and !cc.car_name.blank?) }
        if @league.save
          generate_entries
          format.html  { render :partial => "league_register"}
        else
          generate_entries
          format.html  { render :partial => "league_register"}
        end
      else
        generate_entries
        format.html  { render :partial => "league_register"}
      end
    end
  end
  
  def exit_league
    @league = League.find(params[:id])
    if params[:user_id] and params[:id] and @league.organiser.eql?(current_user)
      u = User.find(params[:user_id])
      @league.unregister_driver(u)
      f_notice = "Removed #{u.username}(#{u.psn_name})"
    else
      @league.unregister_driver(current_user)
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
  
  private
    def generate_entries
      @entries_by_class = {}
      unless @league.car_classes.blank?
        @league.car_classes.each do |cc|
          @entries_by_class[cc.name] = []
          cc.league_entries.each {|e| @entries_by_class[cc.name] << e}
        end
      else
        @entries_by_class = @league.league_entries
      end
    end
end
