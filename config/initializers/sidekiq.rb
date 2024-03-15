require 'sidekiq/web'
require 'sidekiq-status'
require 'sidekiq-status/web'
require 'sidekiq/cli'

Sidekiq.configure_server do |config|
  config.redis = {url: 'redis://localhost:6379/0'}

  unless Rails.env == 'test'
    schedule_file = "config/schedule.yml"

    if File.exists?(schedule_file) && Sidekiq.server?
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: 'redis://localhost:6379/0'}
end

