require "application_system_test_case"

class ReelsTest < ApplicationSystemTestCase
  setup do
    @reel = reels(:one)
  end

  test "visiting the index" do
    visit reels_url
    assert_selector "h1", text: "Reels"
  end

  test "should create reel" do
    visit reels_url
    click_on "New reel"

    fill_in "Brand", with: @reel.brand
    fill_in "Gear type", with: @reel.gear_type
    fill_in "Line", with: @reel.line_id
    fill_in "Name", with: @reel.name
    fill_in "Notes", with: @reel.notes
    fill_in "Price", with: @reel.price
    fill_in "Purchase date", with: @reel.purchase_date
    fill_in "Reel type", with: @reel.reel_type
    fill_in "User", with: @reel.user_id
    click_on "Create Reel"

    assert_text "Reel was successfully created"
    click_on "Back"
  end

  test "should update Reel" do
    visit reel_url(@reel)
    click_on "Edit this reel", match: :first

    fill_in "Brand", with: @reel.brand
    fill_in "Gear type", with: @reel.gear_type
    fill_in "Line", with: @reel.line_id
    fill_in "Name", with: @reel.name
    fill_in "Notes", with: @reel.notes
    fill_in "Price", with: @reel.price
    fill_in "Purchase date", with: @reel.purchase_date
    fill_in "Reel type", with: @reel.reel_type
    fill_in "User", with: @reel.user_id
    click_on "Update Reel"

    assert_text "Reel was successfully updated"
    click_on "Back"
  end

  test "should destroy Reel" do
    visit reel_url(@reel)
    accept_confirm { click_on "Destroy this reel", match: :first }

    assert_text "Reel was successfully destroyed"
  end
end
