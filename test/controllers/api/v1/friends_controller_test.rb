require 'test_helper'

class Api::V1::FriendsControllerTest < ActionDispatch::IntegrationTest

  test "Request friend" do
    post '/api/v1/friends/add',
      params: { friends: ['andy@example.com', 'john@example.com']}
    assert_response :success
  end

  test "Retrieve friends list" do
    get '/api/v1/friends/list',
      params: { email: 'andy@example.com' }
    assert_response :success
  end

  test "Retrieve common friends list" do
    post '/api/v1/friends/subscribe',
      params: { requestor: 'common@example.com', target: 'john@example.com' }
    post '/api/v1/friends/subscribe',
      params: { requestor: 'common@example.com', target: 'andy@example.com' }

    get '/api/v1/friends/common',
      params: { friends: [ 'andy@example.com', 'john@example.com'] }
    assert_equal '{"success":true,"friends":["common@example.com"],"count":1}', @response.body
  end

  test "Subscribe to updates" do
    post '/api/v1/friends/subscribe',
      params: { requestor: 'lisa@example.com', target: 'john@example.com' }
    assert_response :success
  end

  test "Block updates" do
    put "/api/v1/friends/unsubscribe",
      params: { requestor: 'andy@example.com', target: 'john@example.com' }
    assert_response :success
  end

  test "Receive updates" do
    post '/api/v1/friends/subscribe',
      params: { requestor: 'lisa@example.com', target: 'john@example.com' }

    get "/api/v1/friends/updates",
      params: { sender: 'john@example.com', text: 'Hello World! kate@example.com' }
    assert_equal '{"success":true,"recipients":["lisa@example.com","kate@example.com"]}', @response.body
  end
end
