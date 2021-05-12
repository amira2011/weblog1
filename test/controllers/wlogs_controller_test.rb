require "test_helper"

class WlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wlogs_index_url
    assert_response :success
  end
end
