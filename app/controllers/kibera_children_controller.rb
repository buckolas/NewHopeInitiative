class KiberaChildrenController < ApplicationController
  # GET /kibera_children
  # GET /kibera_children.json
  
  def index
    if params[:per_page]
      session[:per_page] = params[:per_page].to_i
    end
    
    if params[:class_in_school]
      session[:class_in_school] = (params[:class_in_school].downcase == "all") ? nil : params[:class_in_school]
    end
    
    @kibera_children = KiberaChild.find_children(params[:search], session[:class_in_school]).page(params[:page]).per_page(session[:per_page] || 25)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kibera_children }
    end
  end

  # GET /kibera_children/1
  # GET /kibera_children/1.json
  def show
    @kibera_child = KiberaChild.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @kibera_child }
    end
  end

  # GET /kibera_children/new
  # GET /kibera_children/new.json
  def new
    @kibera_child = KiberaChild.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @kibera_child }
    end
  end

  # GET /kibera_children/1/edit
  def edit
    @kibera_child = KiberaChild.find(params[:id])
  end

  # POST /kibera_children
  # POST /kibera_children.json
  def create
    @kibera_child = KiberaChild.new(params[:kibera_child])

    respond_to do |format|
      if @kibera_child.save
        format.html { redirect_to @kibera_child, :notice => 'Kibera child was successfully created.' }
        format.json { render :json => @kibera_child, :status => :created, :location => @kibera_child }
      else
        format.html { render :action => "new" }
        format.json { render :json => @kibera_child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kibera_children/1
  # PUT /kibera_children/1.json
  def update
    @kibera_child = KiberaChild.find(params[:id])

    respond_to do |format|
      if @kibera_child.update_attributes(params[:kibera_child])
        format.html { redirect_to @kibera_child, :notice => 'Kibera child was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @kibera_child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kibera_children/1
  # DELETE /kibera_children/1.json
  def destroy
    @kibera_child = KiberaChild.find(params[:id])
    @kibera_child.destroy

    respond_to do |format|
      format.html { redirect_to kibera_children_url }
      format.json { head :ok }
    end
  end
  
end
