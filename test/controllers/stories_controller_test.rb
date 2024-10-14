require "test_helper"

class StoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story = stories(:one)
  end

  test "should get index" do
    get stories_url
    assert_response :success
  end

  test "should show story" do
    get story_url(@story)
    assert_response :success
  end
end
