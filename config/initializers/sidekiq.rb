Sidekiq.configure_server do |config|
  config.redis = { url:  ENV['SIDEKIQ_REDIS'] , network_timeout: 5 }
end if Rails.env.production?

Sidekiq.configure_client do |config|
   config.redis = { url:  ENV['SIDEKIQ_REDIS'] , network_timeout: 5 }
end if Rails.env.production?