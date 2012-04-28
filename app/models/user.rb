class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  acts_as_authentic do |c|
    c.logged_in_timeout = 30.minutes
  end
end
