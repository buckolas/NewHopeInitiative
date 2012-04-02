class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  acts_as_authentic
end
