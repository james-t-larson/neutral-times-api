require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = build(:article)
  end

  test "valid article" do
    assert @article.valid?
  end

  test "invalid without title" do
    @article.title = nil
    assert_not @article.valid?, "Article is valid without a title"
    assert_not_nil @article.errors[:title], "No validation error for title present"
  end

  test "invalid without summary" do
    @article.summary = nil
    assert_not @article.valid?, "Article is valid without a summary"
    assert_not_nil @article.errors[:summary], "No validation error for summary present"
  end

  test "invalid without content" do
    @article.content = nil
    assert_not @article.valid?, "Article is valid without content"
    assert_not_nil @article.errors[:content], "No validation error for content present"
  end

  test "invalid without sources" do
    @article.sources = nil
    assert_not @article.valid?, "Article is valid without sources"
    assert_not_nil @article.errors[:sources], "No validation error for sources present"
  end

  test "default scope includes only today's articles" do
    @article.save!
    old_article = create(:article, created_at: 1.day.ago)

    articles_today = Article.published_today

    assert_includes articles_today, @article, "Today's article should be included"
    assert_not_includes articles_today, old_article, "Old article should not be included"
  end
end
