require "test_helper"

class StoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story = create(:story, contents_count: 5)
  end

  test "should get index and return the correct stories" do
    get stories_url
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal 1, json_response.length

    story_data = json_response.first
    assert_equal @story.id, story_data["id"]
    assert_equal @story.title, story_data["title"]
    assert_equal @story.summary, story_data["summary"]
    assert_equal @story.published_at.as_json, story_data["published_at"]
    assert_equal @story.created_at.as_json, story_data["created_at"]
    assert_equal @story.updated_at.as_json, story_data["updated_at"]

    assert_equal 5, story_data["contents"].length
    story_data["contents"].each_with_index do |content, index|
      assert_equal @story.contents[index].id, content["id"]
      assert_equal @story.contents[index].sub_title, content["sub_title"]
      assert_equal @story.contents[index].text, content["text"]
      assert_equal @story.id, content["story_id"]
      assert_equal @story.contents[index].created_at.as_json, content["created_at"]
      assert_equal @story.contents[index].updated_at.as_json, content["updated_at"]
    end
  end

  test "should show story with correct content" do
    get story_url(id: @story)
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal @story.id, json_response["id"]
    assert_equal @story.title, json_response["title"]
    assert_equal @story.summary, json_response["summary"]
    assert_equal @story.published_at.as_json, json_response["published_at"]
    assert_equal @story.created_at.as_json, json_response["created_at"]
    assert_equal @story.updated_at.as_json, json_response["updated_at"]

    assert_equal 5, json_response["contents"].length
    json_response["contents"].each_with_index do |content, index|
      assert_equal @story.contents[index].id, content["id"]
      assert_equal @story.contents[index].sub_title, content["sub_title"]
      assert_equal @story.contents[index].text, content["text"]
      assert_equal @story.id, content["story_id"]
      assert_equal @story.contents[index].created_at.as_json, content["created_at"]
      assert_equal @story.contents[index].updated_at.as_json, content["updated_at"]
    end
  end

  test "should return not found for invalid story id" do
    get story_url(id: "invalid-id")

    assert_response :not_found

    json_response = JSON.parse(response.body)

    assert_equal "Story not found", json_response["error"]
  end
end
