module Articles
  class Generate
    def self.perform
      prepped_groups = []
      Category.all.each do |category|
        groups = EventRegistry::DataPreperation.prepare(category)
        prepped_groups = prepped_groups + groups
      end

      prepped_groups.each do |group|
        FetchAndSaveArticlesJob.perform_later(group)
      end
    end
  end
end
