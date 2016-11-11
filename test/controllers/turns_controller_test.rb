require 'test_helper'

class TurnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @turn = turns(:weekly_1)
  end

  test "should get index" do
    get turns_url, as: :json
    assert_response :success
  end

  test "should create turn" do
    skip "working on it"
    assert_difference('Turn.count') do
      post turns_url, params: { turn: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show turn" do
    get turn_url(@turn), as: :json
    assert_response :success
  end

  test "should update turn" do
    patch turn_url(@turn), params: { turn: {  } }, as: :json
    assert_response 200
  end

  test "should destroy turn" do
    assert_difference('Turn.count', -1) do
      delete turn_url(@turn), as: :json
    end

    assert_response 204
  end
end
