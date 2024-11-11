require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'Edge cases for validations' do
    let(:article) { Article.new(title: 'Sample Title', summary: 'Sample Summary', content: 'Sample Content', sources: 'Sample Source') }

    it 'is invalid without a title' do
      article.title = nil
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'is invalid with an empty string title' do
      article.title = ' '
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a summary' do
      article.summary = nil
      expect(article).not_to be_valid
      expect(article.errors[:summary]).to include("can't be blank")
    end

    it 'is invalid with an empty string summary' do
      article.summary = ' '
      expect(article).not_to be_valid
      expect(article.errors[:summary]).to include("can't be blank")
    end

    it 'is invalid without content' do
      article.content = nil
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it 'is invalid without sources' do
      article.sources = nil
      expect(article).not_to be_valid
      expect(article.errors[:sources]).to include("can't be blank")
    end
  end

  describe 'Edge cases for scopes' do
    before do
      # Setting up articles at boundary times
      @start_of_today = Time.now.beginning_of_day
      @end_of_today = Time.now.end_of_day

      @article_start_of_day = Article.create!(title: 'Start of Day', summary: 'Summary', content: 'Content', sources: 'Source', created_at: @start_of_today)
      @article_end_of_day = Article.create!(title: 'End of Day', summary: 'Summary', content: 'Content', sources: 'Source', created_at: @end_of_today)
    end

    context 'published_today' do
      it 'includes articles created exactly at the start of the day' do
        expect(Article.published_today).to include(@article_start_of_day)
      end

      it 'includes articles created exactly at the end of the day' do
        expect(Article.published_today).to include(@article_end_of_day)
      end

      it 'excludes articles created before today' do
        article_yesterday = Article.create!(title: 'Yesterday', summary: 'Summary', content: 'Content', sources: 'Source', created_at: 1.day.ago)
        expect(Article.published_today).not_to include(article_yesterday)
      end
    end

    context 'published_between' do
      it 'includes articles created at the exact start and end times of the range' do
        start_date = @start_of_today
        end_date = @end_of_today
        expect(Article.published_between(start_date, end_date)).to include(@article_start_of_day, @article_end_of_day)
      end

      it 'excludes articles outside of the given date range' do
        article_outside_range = Article.create!(title: 'Outside Range', summary: 'Summary', content: 'Content', sources: 'Source', created_at: 2.days.ago)
        start_date = 1.day.ago.beginning_of_day
        end_date = Time.now.beginning_of_day
        expect(Article.published_between(start_date, end_date)).not_to include(article_outside_range)
      end
    end

    context 'recent' do
      it 'includes articles created within the last 7 days' do
        recent_article = Article.create!(title: 'Recent', summary: 'Summary', content: 'Content', sources: 'Source', created_at: 3.days.ago)
        expect(Article.recent).to include(recent_article)
      end

      it 'excludes articles created more than 7 days ago' do
        older_article = Article.create!(title: 'Old Article', summary: 'Summary', content: 'Content', sources: 'Source', created_at: 8.days.ago)
        expect(Article.recent).not_to include(older_article)
      end
    end
  end
end
