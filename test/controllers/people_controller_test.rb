class MyControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get people_url
  assert_response :success
  end

  test "empty search should not cause exception" do
    get people_url, params: { search: ''}
    assert_response :success
  end

  test "should return no file" do
    post upload_file_path
    assert_response :redirect
    assert_equal "File not Found", flash[:notice]
  end

end