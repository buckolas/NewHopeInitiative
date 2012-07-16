class ChildPhotosController < ApplicationController
  def create
    @child_photo = ChildPhoto.new(:kibera_child_id => params[:kibera_child_id], :image => params[:image])
    begin
      if @child_photo.save
        render :json => @child_photo, :layout => false
      else
        render :json => { :errors => @child_photo.errors.full_messages }, :status => 422, :layout => false
      end
    rescue Exception => e
      render :json => { :errors => e.to_s }, :status => 500, :layout => false
    end
  end
  
  def destroy
    if params[:id] != 'aws'
      # Use CarrierWave to delete the image from the DB and AWS
      @child_photo = ChildPhoto.find(params[:id])
      @child_photo.remove_image!
      @child_photo.destroy
    else
      # Delete the image on AWS only
      files = AWS_BUCKET.files.all(:prefix => params[:key])
      files[0].destroy if files.count > 0
    end
    
    render :json => {:status => 'success'}, :status => :ok
  end
end
