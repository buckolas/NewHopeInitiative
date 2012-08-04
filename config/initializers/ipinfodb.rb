IPINFODB_CONFIG = (YAML.load_file(Rails.root.join('config', 'ipinfodb.yml'))[Rails.env] rescue {}).merge(ENV)

IPINFODB_API_KEY = IPINFODB_CONFIG["ipinfodb_api_key"]
