class User < ActiveRecord::Base
  validates_presence_of :firstName, :lastName, :username, :email
  validates_uniqueness_of :email, :username
  acts_as_authentic
end
