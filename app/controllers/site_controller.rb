class SiteController < ApplicationController
  
  def edit
    @site = site
  end

  def show
    @site = site
  end
  
  def update
    @site = site
    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = "Your site was updated."
        format.html { redirect_to account_path }
      else
        flash[:alert] = ""
        @site.errors.full_messages.each {|error| flash[:alert] << "#{error}, " }
        flash[:alert].chop!
        logger.info flash[:alert].chop!
        format.html { redirect_to site_edit_path }
      end
    end
  end

end
