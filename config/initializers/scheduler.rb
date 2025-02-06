Rails.application.config.after_initialize do
  Rails.logger.info "Scheduler initializer has started at #{Time.now}"
  scheduler = Rufus::Scheduler.singleton

  scheduler.cron "5 0 * * *" do
    Rails.logger.info "Running Scheduler task at midnight... (#{Time.now.in_time_zone('Pacific Time (US & Canada)')})"
    Articles::Generate.perform()
  end
end
