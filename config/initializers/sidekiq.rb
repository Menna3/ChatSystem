#schedule_file = "config/schedule.yml"
#if File.exist?(schedule_file) && Sidekiq.server?
#  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
#end
schedule = [
  {'class' => Application, 'cron'  => '*/1 * * * *', 'active_job' => true }
]
Sidekiq.configure_server do |config|
 config.redis = { host:'127.0.0.1', port: 6379, db: 1 }
 Sidekiq::Cron::Job.load_from_array! schedule
end
Sidekiq.configure_client do |config|
 config.redis = { host:'127.0.0.1', port: 6379, db: 1 }
end