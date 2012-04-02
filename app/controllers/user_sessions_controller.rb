class UserSessionsController < ApplicationController
  skip_before_filter :require_login
  before_filter :is_currently_logged_in, :only => [:new]
    
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_url, :notice => "Successfully logged in."
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    redirect_to root_url, :notice => "Successfully logged out."
  end
  
  private
  
  def is_currently_logged_in
      if current_user_session
          redirect_to root_url
      end
  end
end
