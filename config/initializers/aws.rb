AWS_CONFIG = (YAML.load_file(Rails.root.join('config', 'aws.yml'))[Rails.env] rescue {}).merge(ENV)
