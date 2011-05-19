class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper_method :site
  
  def site
    return @site if defined?(@site)
    @site = Site.first
  end
end
