require "test_helper"

class ReelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reel = reels(:one)
  end

  test "should get index" do
    get reels_url
    assert_response :success
  end

  test "should get new" do
    get new_reel_url
    assert_response :success
  end

  test "should create reel" do
    assert_difference("Reel.count") do
      post reels_url, params: { reel: { brand: @reel.brand, gear_type: @reel.gear_type, line_id: @reel.line_id, name: @reel.name, notes: @reel.notes, price: @reel.price, purchase_date: @reel.purchase_date, reel_type: @reel.reel_type, user_id: @reel.user_id } }
    end

    assert_redirected_to reel_url(Reel.last)
  end

  test "should show reel" do
    get reel_url(@reel)
    assert_response :success
  end

  test "should get edit" do
    get edit_reel_url(@reel)
    assert_response :success
  end

  test "should update reel" do
    patch reel_url(@reel), params: { reel: { brand: @reel.brand, gear_type: @reel.gear_type, line_id: @reel.line_id, name: @reel.name, notes: @reel.notes, price: @reel.price, purchase_date: @reel.purchase_date, reel_type: @reel.reel_type, user_id: @reel.user_id } }
    assert_redirected_to reel_url(@reel)
  end

  test "should destroy reel" do
    assert_difference("Reel.count", -1) do
      delete reel_url(@reel)
    end

    assert_redirected_to reels_url
  end
end
