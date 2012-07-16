AWS_CONFIG = (YAML.load_file(Rails.root.join('config', 'aws.yml'))[Rails.env] rescue {}).merge(ENV)

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => AWS_CONFIG['access_key_id'],
    :aws_secret_access_key  => AWS_CONFIG['secret_access_key']
  }
  config.fog_directory  = AWS_CONFIG['s3_bucket']
  config.fog_public     = false
  config.fog_authenticated_url_expiration = 43200
end

# create a connection
AWS_CONNECTION = Fog::Storage.new({
  :provider => 'AWS',
  :aws_access_key_id => AWS_CONFIG['access_key_id'],
  :aws_secret_access_key => AWS_CONFIG['secret_access_key']
})

# the S3 bucket
AWS_BUCKET = AWS_CONNECTION.directories.get(AWS_CONFIG['s3_bucket'])