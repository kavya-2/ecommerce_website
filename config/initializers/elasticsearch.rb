# Load configuration from YAML file
config = Rails.application.config_for(:elasticsearch)

# Set up the Elasticsearch client with authentication
Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: config['host'],
  port: config['port'],
  scheme: config['scheme'],
  log: config['log'],
  user: config['elastic'],        # Elasticsearch username
  password: config['password'], # Elasticsearch password
  transport_options: {
    ssl: { verify: false }
  }
)