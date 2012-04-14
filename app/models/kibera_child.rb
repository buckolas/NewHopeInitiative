require 'rubygems'
require 'fog'

class KiberaChild < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :gender, :grade, :birth_date
  validate :child_name_is_unique
  
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
  
  def photos
    # create a connection
    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => AWS_CONFIG['access_key_id'],
      :aws_secret_access_key    => AWS_CONFIG['secret_access_key']
    })

    # the S3 bucket
    directory = connection.directories.get(AWS_CONFIG['s3_bucket'])

    # all child images
    photos = []
    files = directory.files.all(:prefix => 'img/' + first_name + ' ' + last_name)
    files.each {|file| photos << file.url(Time.now+43200) }
    photos
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
