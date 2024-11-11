Rails.application.config.after_initialize do
  Rails.logger.info "Scheduler initializer has started at #{Time.now}"
  scheduler = Rufus::Scheduler.singleton

  if Article.published_today.empty? && !Rails.env.test?
    Rails.logger.info "No articles found for today, generating new articles..."
    ArticleGenerationService.new.generate_and_save_articles
  end

  scheduler.cron "0 12 * * *" do
    Rails.logger.info "Running ArticleGenerationService task at noon..."
    ArticleGenerationService.new.generate_and_save_articles
  end

  scheduler.cron "0 0 * * *" do
    Rails.logger.info "Running ArticleGenerationService task at midnight..."
    ArticleGenerationService.new.generate_and_save_articles
  end
end
