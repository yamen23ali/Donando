Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://pub-redis-19163.us-east-1-1.1.ec2.garantiadata.com:19163', password: "donando", network_timeout: 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://pub-redis-19163.us-east-1-1.1.ec2.garantiadata.com:19163', password: "donando", network_timeout: 5 }
end