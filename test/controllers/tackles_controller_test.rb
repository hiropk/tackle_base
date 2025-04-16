require "test_helper"

class TacklesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tackle = tackles(:one)
  end

  test "should get index" do
    get tackles_url
    assert_response :success
  end

  test "should get new" do
    get new_tackle_url
    assert_response :success
  end

  test "should create tackle" do
    assert_difference("Tackle.count") do
      post tackles_url, params: { tackle: { knot: @tackle.knot, leader_id: @tackle.leader_id, name: @tackle.name, notes: @tackle.notes, reel_id: @tackle.reel_id, rod_id: @tackle.rod_id, user_id: @tackle.user_id } }
    end

    assert_redirected_to tackle_url(Tackle.last)
  end

  test "should show tackle" do
    get tackle_url(@tackle)
    assert_response :success
  end

  test "should get edit" do
    get edit_tackle_url(@tackle)
    assert_response :success
  end

  test "should update tackle" do
    patch tackle_url(@tackle), params: { tackle: { knot: @tackle.knot, leader_id: @tackle.leader_id, name: @tackle.name, notes: @tackle.notes, reel_id: @tackle.reel_id, rod_id: @tackle.rod_id, user_id: @tackle.user_id } }
    assert_redirected_to tackle_url(@tackle)
  end

  test "should destroy tackle" do
    assert_difference("Tackle.count", -1) do
      delete tackle_url(@tackle)
    end

    assert_redirected_to tackles_url
  end
end
