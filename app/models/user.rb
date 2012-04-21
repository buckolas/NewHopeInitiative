class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  acts_as_authentic do |c|
    c.logged_in_timeout = 30.minutes
  end
end
