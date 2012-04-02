class KiberaChild < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :gender, :grade, :birth_date
  validate :child_name_is_unique
  mount_uploader :image, ImageUploader
  
  def self.find_children(search, grade)
    children = KiberaChild.order("last_name ASC, first_name ASC")
    children = children.where("last_name LIKE ? OR first_name LIKE ?", "%" + search + "%", "%" + search + "%") if search
    children = children.where("grade = ?", String.to_grade(grade)) if grade
    children
  end
  
  private 
  
  def child_name_is_unique
    return unless first_name && last_name
    
    if id
      if KiberaChild.where("lower(last_name) = :last_name AND lower(first_name) = :first_name AND id <> :id", :last_name => last_name.downcase, :first_name => first_name.downcase, :id => id).first
        errors.add(:first_name, "Child with name '" + first_name + " " + last_name + "' already exists")
        errors.add(:last_name, "Child with name '" + first_name + " " + last_name + "' already exists")
      end
    elsif KiberaChild.where("lower(last_name) = :last_name AND lower(first_name) = :first_name", :last_name => last_name.downcase, :first_name => first_name.downcase).first
      errors.add(:first_name, "Child with name '" + first_name + " " + last_name + "' already exists")
      errors.add(:last_name, "Child with name '" + first_name + " " + last_name + "' already exists")
    end
  end
end
