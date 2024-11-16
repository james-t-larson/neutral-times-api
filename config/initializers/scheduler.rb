Rails.application.config.after_initialize do
  Rails.logger.info "Scheduler initializer has started at #{Time.now}"
  scheduler = Rufus::Scheduler.singleton

  scheduler.cron "0 12 * * *" do
    Rails.logger.info "Running ArticleGenerationService task at noon..."
    gen = ArticleGenerationService.new
    gen.generate_and_save_articles
  end

  scheduler.cron "0 0 * * *" do
    Rails.logger.info "Running ArticleGenerationService task at midnight..."
    gen = ArticleGenerationService.new
    gen.generate_and_save_articles
  end
end
