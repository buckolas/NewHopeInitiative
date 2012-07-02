class ChildPhoto < ActiveRecord::Base
  belongs_to :kibera_child
  mount_uploader :image, ChildPhotoUploader
end
