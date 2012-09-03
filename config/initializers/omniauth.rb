OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, 'H8W7R0aM3XMsxwOjIx1qyw', 'x7yVmko6OPUMsUcp2ORTi2W9A2V51kU7y8SYfeY'

end
