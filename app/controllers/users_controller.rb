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
    @user = User.find(params[:id])
    is_self = @user.id == current_user.id
    if is_self || (!is_self && current_user.is_admin)
      is_old_empty = params[:user][:old_password].nil? || params[:user][:old_password].empty?
      is_new_empty = (params[:user][:password].nil? || params[:user][:password].empty?) && (params[:user][:password_confirmation].nil? || params[:user][:password_confirmation].empty?)
      if !is_self || is_new_empty || (!is_old_empty && !is_new_empty && @user.valid_password?(params[:user][:old_password]))
        if @user.update_attributes(params[:user].reject{|key, value| key == "old_password"})
          redirect_to root_url, :notice => "Successfully updated your profile." if is_self
          redirect_to users_path, :notice => "Successfully updated user's profile." unless is_self
        else
          render :action => 'edit'
        end
      else
        @user.errors.add(:old_password, 'is incorrect.')
        render :action => 'edit'
      end
    else
      redirect_to root_url
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
