require "application_system_test_case"

class RodsTest < ApplicationSystemTestCase
  setup do
    @rod = rods(:one)
  end

  test "visiting the index" do
    visit rods_url
    assert_selector "h1", text: "Rods"
  end

  test "should create rod" do
    visit rods_url
    click_on "New rod"

    fill_in "Brand", with: @rod.brand
    fill_in "Fishing type", with: @rod.fishing_type
    fill_in "Length", with: @rod.length
    fill_in "Max weight", with: @rod.max_weight
    fill_in "Min weight", with: @rod.min_weight
    fill_in "Name", with: @rod.name
    fill_in "Notes", with: @rod.notes
    fill_in "Power", with: @rod.power
    fill_in "Purchase date", with: @rod.purchase_date
    fill_in "Reel type", with: @rod.reel_type
    click_on "Create Rod"

    assert_text "Rod was successfully created"
    click_on "Back"
  end

  test "should update Rod" do
    visit rod_url(@rod)
    click_on "Edit this rod", match: :first

    fill_in "Brand", with: @rod.brand
    fill_in "Fishing type", with: @rod.fishing_type
    fill_in "Length", with: @rod.length
    fill_in "Max weight", with: @rod.max_weight
    fill_in "Min weight", with: @rod.min_weight
    fill_in "Name", with: @rod.name
    fill_in "Notes", with: @rod.notes
    fill_in "Power", with: @rod.power
    fill_in "Purchase date", with: @rod.purchase_date
    fill_in "Reel type", with: @rod.reel_type
    click_on "Update Rod"

    assert_text "Rod was successfully updated"
    click_on "Back"
  end

  test "should destroy Rod" do
    visit rod_url(@rod)
    accept_confirm { click_on "Destroy this rod", match: :first }

    assert_text "Rod was successfully destroyed"
  end
end
