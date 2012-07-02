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
    @child_photo = ChildPhoto.find(params[:id])
    @child_photo.remove_image!
    @child_photo.destroy
    
    render :json => {:status => 'success'}, :status => :ok
  end
end
