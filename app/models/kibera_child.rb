require 'rubygems'
require 'fog'

class KiberaChild < ActiveRecord::Base
  has_many :child_photos, :dependent => :destroy
  validates_presence_of :first_name, :last_name, :gender, :grade, :birth_date
  validate :child_name_is_unique
  
  def birth_date_formatted
     return birth_date.strftime '%m/%d/%Y' if birth_date
     birth_date
  end
  
  def assessment_documentation_date_formatted
    return assessment_documentation_date.strftime '%m/%d/%Y' if assessment_documentation_date
    assessment_documentation_date
  end
  
  def tb_date_formatted
    return tb_date.strftime '%m/%d/%Y' if tb_date
    tb_date
  end
  
  def typhoid_date_formatted
    return typhoid_date.strftime '%m/%d/%Y' if typhoid_date
    typhoid_date
  end
  
  def malaria_date_formatted
    return malaria_date.strftime '%m/%d/%Y' if malaria_date
    malaria_date
  end
  
  def hygenall_products_distribution_date_formatted
    return hygenall_products_distribution_date.strftime '%m/%d/%Y' if hygenall_products_distribution_date
    hygenall_products_distribution_date
  end
  
  def physical_examination_date_formatted
    return physical_examination_date.strftime '%m/%d/%Y' if physical_examination_date
    physical_examination_date
  end
  
  def menstrual_products_distribution_date_formatted
    return menstrual_products_distribution_date.strftime '%m/%d/%Y' if menstrual_products_distribution_date
    menstrual_products_distribution_date
  end
  
  def self.find_children(search, grade)
    children = KiberaChild.order("last_name ASC, first_name ASC")
    children = children.where("lower(last_name) LIKE ? OR lower(first_name) LIKE ?", "%" + search.downcase + "%", "%" + search.downcase + "%") if search
    children = children.where("grade = ?", String.to_grade(grade)) if grade
    children
  end
  
  def age
    now = Date.today
    age = now.year - birth_date.year
    age -= 1 if (birth_date.month > now.month || (birth_date.month >= now.month && birth_date.day > now.day))
    age
  end
  
  def aws_photos
    # photos = []
    # files = directory.files.all(:prefix => 'img/' + first_name + ' ' + last_name)
    # files.each {|file| photos << file.url(Time.now+43200) }
    # photos
    
    # @child_photos = Rails.cache.fetch("/kibera_children/#{object_id}/photos", :expires_in => 12.hours) do
    #         @kibera_child.photos
    #     end
    
    # Return all child images that are found in the root folder of the AWS bucket
    AWS_BUCKET.files.all(:prefix => 'img/' + first_name + ' ' + last_name)
  end
  
  private 
  
  def child_name_is_unique
    return unless first_name && last_name
    
    if id
      if KiberaChild.where("lower(last_name) = :last_name AND lower(first_name) = :first_name AND id <> :id", :last_name => last_name.downcase, :first_name => first_name.downcase, :id => id).first
        errors.add(:first_name, "Child with name '" + first_name + " " + last_name + "' already exists")
        errors.add(:last_name, "")
      end
    elsif KiberaChild.where("lower(last_name) = :last_name AND lower(first_name) = :first_name", :last_name => last_name.downcase, :first_name => first_name.downcase).first
      errors.add(:first_name, "Child with name '" + first_name + " " + last_name + "' already exists")
      errors.add(:last_name, "")
    end
  end
end
