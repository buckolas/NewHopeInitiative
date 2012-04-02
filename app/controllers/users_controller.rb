class UsersController < ApplicationController
  before_filter :is_admin, :only => [:new, :index, :create, :destroy]
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
  
  def new
    @user = User.new
  end
  
  def edit
    if params[:id] == 'current'
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, :notice => "User created successfully."
    else
      render :action => 'new'
    end
  end
  
  def update
    if(params[:id] == 'current')
      @user = current_user
      if @user.update_attributes(params[:user])
        redirect_to root_url, :notice => "Successfully updated your profile."
      else
        render :action => 'edit'
      end
    else
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to users_url, :notice => "Successfully updated user profile."
      else
        render :action => 'edit'
      end
    end
  end
  
  def destroy
    if params[:id] == 'current' || User.find(params[:id]) == current_user
      redirect_to users_url, :error => "You cannot delete your own account."
    else
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :ok }
      end
    end
  end
  
  private
  
  def is_admin
      unless current_user.is_admin
          redirect_to kibera_children_path
      end
  end
    
end
