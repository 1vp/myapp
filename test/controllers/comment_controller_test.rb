require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get commenter:string" do
    get comment_commenter:string_url
    assert_response :success
  end

  test "should get body:text" do
    get comment_body:text_url
    assert_response :success
  end

  test "should get article:references" do
    get comment_article:references_url
    assert_response :success
  end

end
