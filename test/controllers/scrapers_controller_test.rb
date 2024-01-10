require "test_helper"

class ScrapersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scrapers_index_url
    assert_response :success
  end
end
