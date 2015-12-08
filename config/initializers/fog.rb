
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    aws_access_key_id:     "#{ENV['WN_AWS_ID']}",                        # required
    aws_secret_access_key: "#{ENV['WN_AWS_KEY']}",
    region:                'us-east-1'
  }
  config.fog_directory  = 'what-next'                          # required
  config.fog_public     = true                                        # optional, defaults to true
end
