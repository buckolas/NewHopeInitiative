namespace :heroku do
  task :config do
    puts "Reading config/aws.yml and sending config vars to Heroku..."
    CONFIG = YAML.load_file(Rails.root.join('config', 'aws.yml'))[Rails.env] rescue {}
    command = "heroku config:add"
    CONFIG.each {|key, val| command << " #{key}=#{val} " if val }
    system command  
  end
end