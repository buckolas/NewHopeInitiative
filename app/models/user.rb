class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :username, :email
  validates_uniqueness_of :email, :username
  acts_as_authentic
end
