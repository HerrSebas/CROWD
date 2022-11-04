require "test_helper"

class PdfControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pdf_show_url
    assert_response :success
  end
end
