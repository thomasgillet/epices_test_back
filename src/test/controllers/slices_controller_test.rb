require "test_helper"

class SlicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get slices_index_url
    assert_response :success
  end

  test "should get new" do
    get slices_new_url
    assert_response :success
  end
end
