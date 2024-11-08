require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = create(:article)
  end

  test "should get index and return the correct articles" do
    get articles_url
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal 1, json_response.length

    article_data = json_response.first
    assert_equal @article.id, article_data["id"]
    assert_equal @article.title, article_data["title"]
    assert_equal @article.summary, article_data["summary"]
    assert_equal @article.created_at.as_json, article_data["created_at"]
    assert_equal @article.updated_at.as_json, article_data["updated_at"]
    assert_equal @article.content.as_json, article_data["content"]
    assert_equal @article.sources.as_json, article_data["sources"]
  end

  test "should show article with correct content" do
    get article_url(id: @article)
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal @article.id, json_response["id"]
    assert_equal @article.title, json_response["title"]
    assert_equal @article.summary, json_response["summary"]
    assert_equal @article.created_at.as_json, json_response["created_at"]
    assert_equal @article.updated_at.as_json, json_response["updated_at"]
    assert_equal @article.content.as_json, json_response["content"]
    assert_equal @article.sources.as_json, json_response["sources"]
  end

  test "should return invalid date format if iso8601 is not used" do
    get articles_url(date: "2024-17-04")

    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body)

    assert_equal "Invalid date format. Please provide the date in ISO 8601 format (e.g., '2023-11-07T15:30:00Z' or '2023-11-07') (eg. YYYY-MM-DD).", json_response["error"]
  end

  test "should return not found for invalid article id" do
    get article_url(id: "invalid-id")

    assert_response :not_found

    json_response = JSON.parse(response.body)

    assert_equal "Article not found", json_response["error"]
  end
end
