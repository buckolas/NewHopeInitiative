GOOGLE_CONFIG = (YAML.load_file(Rails.root.join('config', 'google.yml'))[Rails.env] rescue {}).merge(ENV)

GOOGLE_API_KEY = GOOGLE_CONFIG["google_api_key"]
