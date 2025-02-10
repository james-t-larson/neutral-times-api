module Articles
  class Generate
    def self.perform
      prepped_groups = []
      Category.all.each do |category|
        groups = EventRegistry::DataPreperation.prepare(category)
        prepped_groups = prepped_groups + groups
      end

      puts prepped_groups.first.deep_transform_keys(&:to_s)

      prepped_groups.each do |group|
        FetchAndSaveArticlesJob.perform_async(group.deep_transform_keys(&:to_s))
      end
    end
  end
end
