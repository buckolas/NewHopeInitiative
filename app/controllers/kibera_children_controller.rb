class KiberaChildrenController < ApplicationController
  before_filter :format_dates, :only => [:create, :update]
  
  # GET /kibera_children
  # GET /kibera_children.json
  def index
    if params[:per_page]
      session[:per_page] = params[:per_page].to_i
    end

    if params[:grade]
      session[:grade] = (params[:grade].downcase == "all") ? nil : params[:grade]
    end

    if params[:search]
      session[:search] = (params[:search].empty?) ? nil : params[:search]
      session[:per_page] = nil
      session[:grade] = nil
    end

    @kibera_children = KiberaChild.find_children(session[:search], session[:grade]).page(params[:page]).per_page(session[:per_page] || 25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kibera_children }
    end
  end

  # GET /kibera_children/1
  # GET /kibera_children/1.json
  def show
    @kibera_child = KiberaChild.find(params[:id])
    
    # @child_photos = Rails.cache.fetch("/kibera_children/#{object_id}/photos", :expires_in => 12.hours) do
    #         @kibera_child.photos
    #     end

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
    @kibera_child.first_name.strip!
    @kibera_child.last_name.strip!
    respond_to do |format|
      if @kibera_child.save
        format.html { redirect_to @kibera_child, :notice => @kibera_child.first_name + ' ' +  @kibera_child.last_name + ' was successfully created.' }
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
    params[:kibera_child][:first_name].strip!
    params[:kibera_child][:last_name].strip!

    respond_to do |format|
      if @kibera_child.update_attributes(params[:kibera_child])
        format.html { redirect_to @kibera_child, :notice => @kibera_child.first_name + ' ' +  @kibera_child.last_name + ' was successfully updated.' }
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
  
  private 
  
  def format_dates
    params[:kibera_child][:birth_date] = (params[:kibera_child][:birth_date] && params[:kibera_child][:birth_date].length > 0) ? Date.strptime(params[:kibera_child][:birth_date], '%m/%d/%Y') : nil
    params[:kibera_child][:assessment_documentation_date] = (params[:kibera_child][:assessment_documentation_date] && params[:kibera_child][:assessment_documentation_date].length > 0) ? Date.strptime(params[:kibera_child][:assessment_documentation_date], '%m/%d/%Y') : nil
    params[:kibera_child][:tb_date] = (params[:kibera_child][:tb_date] && params[:kibera_child][:tb_date].length > 0) ? Date.strptime(params[:kibera_child][:tb_date], '%m/%d/%Y') : nil
    params[:kibera_child][:typhoid_date] = (params[:kibera_child][:typhoid_date] && params[:kibera_child][:typhoid_date].length > 0) ? Date.strptime(params[:kibera_child][:typhoid_date], '%m/%d/%Y') : nil
    params[:kibera_child][:malaria_date] = (params[:kibera_child][:malaria_date] && params[:kibera_child][:malaria_date].length > 0) ? Date.strptime(params[:kibera_child][:malaria_date], '%m/%d/%Y') : nil
    params[:kibera_child][:hygenall_products_distribution_date] = (params[:kibera_child][:hygenall_products_distribution_date] && params[:kibera_child][:hygenall_products_distribution_date].length > 0) ? Date.strptime(params[:kibera_child][:hygenall_products_distribution_date], '%m/%d/%Y') : nil
    params[:kibera_child][:physical_examination_date] = (params[:kibera_child][:physical_examination_date] && params[:kibera_child][:physical_examination_date].length > 0) ? Date.strptime(params[:kibera_child][:physical_examination_date], '%m/%d/%Y') : nil
    params[:kibera_child][:menstrual_products_distribution_date] = (params[:kibera_child][:menstrual_products_distribution_date] && params[:kibera_child][:menstrual_products_distribution_date].length > 0) ? Date.strptime(params[:kibera_child][:menstrual_products_distribution_date], '%m/%d/%Y') : nil
  end
  
end
