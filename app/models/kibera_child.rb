class KiberaChild < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  mount_uploader :image, ImageUploader
  
  def self.find_children(search, class_in_school)
    children = KiberaChild.order("last_name ASC, first_name ASC")
    children = children.where("last_name LIKE ? OR first_name LIKE ?", "%" + search + "%", "%" + search + "%") if search
    children = children.where("class_in_school = ?", class_in_school) if class_in_school
    children
  end
end
