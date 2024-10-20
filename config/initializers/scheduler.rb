require "rufus-scheduler"

scheduler = Rufus::Scheduler.singleton

Rails.logger.info "Scheduler initializer has started at #{Time.now}"

scheduler.every "12h" do
  Story.generate_story
end
