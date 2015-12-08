CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     "#{ENV['export WN_AWS_ID']}",                        # required
    aws_secret_access_key: "#{ENV['export WN_AWS_KEY']}"                         # required
  }
  config.fog_directory  = 'what-next'
  config.fog_public     = true                            # required
end
