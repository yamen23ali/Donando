Sidekiq.configure_server do |config|
  config.redis = { url:  ENV['SIDEKIQ_REDIS'] , password: ENV['SIDEKIQ_REDIS_PASSWORD'], network_timeout: 5 }
end

Sidekiq.configure_client do |config|
   config.redis = { url:  ENV['SIDEKIQ_REDIS'] , password: ENV['SIDEKIQ_REDIS_PASSWORD'], network_timeout: 5 }
end