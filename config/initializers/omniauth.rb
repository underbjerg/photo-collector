OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => 'email'
  provider :identity, on_failed_registration: lambda { |env|
      IdentitiesController.action(:new).call(env)
    }
end

# Redirect on auth failure, instead of showing an exception, to show a proper error message in case of
# authentication failure with omniauth identity
OmniAuth.config.on_failure = Proc.new { |env|
  SessionsController.action(:failure).call(env)
}