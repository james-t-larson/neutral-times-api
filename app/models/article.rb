class Article < ApplicationRecord
  default_scope { where(published_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
