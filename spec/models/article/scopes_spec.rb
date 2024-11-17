require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "scopes" do
    let!(:article_today) { create(:article, created_at: Time.current) }
    let!(:article_yesterday) { create(:article, created_at: 1.day.ago) }
    let!(:article_last_week) { create(:article, created_at: 7.days.ago) }
    let!(:article_last_month) { create(:article, created_at: 1.month.ago) }

    describe ".published_today" do
      it "returns articles created today" do
        expect(Article.published_today).to include(article_today)
        expect(Article.published_today).not_to include(article_yesterday, article_last_week, article_last_month)
      end
    end

    describe ".published_between" do
      it "returns articles created between the specified dates" do
        start_date = 2.days.ago
        end_date = Time.current

        expect(Article.published_between(start_date, end_date)).to include(article_today, article_yesterday)
        expect(Article.published_between(start_date, end_date)).not_to include(article_last_week, article_last_month)
      end
    end

    describe ".recent" do
      it "returns articles created within the last 7 days" do
        expect(Article.recent).to include(article_today, article_yesterday, article_last_week)
        expect(Article.recent).not_to include(article_last_month)
      end
    end
  end
end
