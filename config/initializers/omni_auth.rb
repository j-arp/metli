Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["ADVENTUR_CLIENT_ID"], ENV["ADVENTUR_CLIENT_SECRET"],{
    :name => 'google',
    :scope => 'userinfo.email'
  }
end
