Rails.application.config.after_initialize do
  Rails.logger.info "Scheduler initializer has started at #{Time.now}"
  scheduler = Rufus::Scheduler.singleton

  scheduler.cron "0 0 * * *" do
    Rails.logger.info "Running ArticleGenerationService task at midnight... (#{Time.now.in_time_zone('Pacific Time (US & Canada)')})"
    gen = ArticleGenerationService.new
    gen.generate_and_save_articles
  end
end
