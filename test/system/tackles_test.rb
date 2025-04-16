require "application_system_test_case"

class TacklesTest < ApplicationSystemTestCase
  setup do
    @tackle = tackles(:one)
  end

  test "visiting the index" do
    visit tackles_url
    assert_selector "h1", text: "Tackles"
  end

  test "should create tackle" do
    visit tackles_url
    click_on "New tackle"

    fill_in "Knot", with: @tackle.knot
    fill_in "Leader", with: @tackle.leader_id
    fill_in "Name", with: @tackle.name
    fill_in "Notes", with: @tackle.notes
    fill_in "Reel", with: @tackle.reel_id
    fill_in "Rod", with: @tackle.rod_id
    fill_in "User", with: @tackle.user_id
    click_on "Create Tackle"

    assert_text "Tackle was successfully created"
    click_on "Back"
  end

  test "should update Tackle" do
    visit tackle_url(@tackle)
    click_on "Edit this tackle", match: :first

    fill_in "Knot", with: @tackle.knot
    fill_in "Leader", with: @tackle.leader_id
    fill_in "Name", with: @tackle.name
    fill_in "Notes", with: @tackle.notes
    fill_in "Reel", with: @tackle.reel_id
    fill_in "Rod", with: @tackle.rod_id
    fill_in "User", with: @tackle.user_id
    click_on "Update Tackle"

    assert_text "Tackle was successfully updated"
    click_on "Back"
  end

  test "should destroy Tackle" do
    visit tackle_url(@tackle)
    accept_confirm { click_on "Destroy this tackle", match: :first }

    assert_text "Tackle was successfully destroyed"
  end
end
