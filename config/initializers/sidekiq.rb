schedule = [
  {'name' => 'countingJob', 'class' => "CountJob", 'cron'  => '0 */1 * * *', 'active_job' => true }
]
Sidekiq.configure_server do |config|
 config.redis = { url:'redis://localhost:6379/1' }
 Sidekiq::Cron::Job.load_from_array! schedule
end
Sidekiq.configure_client do |config|
 config.redis = { url:'redis://localhost:6379/1' }
end