require "rufus-scheduler"

scheduler = Rufus::Scheduler.singleton

Rails.logger.info "Scheduler initializer has started at #{Time.now}"

scheduler.cron "0 12 * * *" do
  Rails.logger.info "Running ArticleGenerationService task at noon..."
  ArticleGenerationService.new.generate_and_save_article
end

scheduler.cron "0 0 * * *" do
  Rails.logger.info "Running ArticleGenerationService task at midnight..."
  ArticleGenerationService.new.generate_and_save_article
end
