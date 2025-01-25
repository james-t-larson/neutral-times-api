module Services
  module Articles
    class GenerationService
      def self.generate
        prepped_groups = []
        Category.all.each do |category|
          groups = Services::EventRegistry::DataPreperation.prepare(category)
          prepped_groups = prepped_groups + groups
        end

        prepped_groups.each do |group|
          FetchAndSaveArticlesJob.perform_later(group)
        end

        if DateTime.now.beginning_of_day < ExternalArticle.last.created_at
          ExternalArticle.last_batch_published.each do |article|
            GenerateAndSaveArticlesJob.perform_later(article)
          end
        end
      end

      private

      def self.wait_until_previous_jobs_complete
        loop do
          if Delayed::Job.count.zero?
            puts "[#{Time.now}]: All jobs completed. Proceeding..."
            break
          else
            puts "[#{Time.now}]: Waiting for other jobs to complete..."
            sleep(1)
          end
        end
      end
    end
  end
end
