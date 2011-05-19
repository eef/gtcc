class AccountController < ApplicationController
  before_filter :find_user
  
  def index
    @page_title = "My Account"
  end

  def edit
    @page_title = "Editing My Account"
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Your account was updated!"
        format.html { redirect_to account_path }
      else
        flash[:alert] = @user.errors
        format.html { redirect_to account_edit_path }
      end
    end
  end
  
  private
    def find_user
      @user = current_user
    end

end
