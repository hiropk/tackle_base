require "application_system_test_case"

class LeadersTest < ApplicationSystemTestCase
  setup do
    @leader = leaders(:one)
  end

  test "visiting the index" do
    visit leaders_url
    assert_selector "h1", text: "Leaders"
  end

  test "should create leader" do
    visit leaders_url
    click_on "New leader"

    fill_in "Brand", with: @leader.brand
    fill_in "Leader rating", with: @leader.leader_rating
    fill_in "Material", with: @leader.material
    fill_in "Name", with: @leader.name
    fill_in "Notes", with: @leader.notes
    fill_in "Price", with: @leader.price
    fill_in "Purchase date", with: @leader.purchase_date
    fill_in "User", with: @leader.user_id
    click_on "Create Leader"

    assert_text "Leader was successfully created"
    click_on "Back"
  end

  test "should update Leader" do
    visit leader_url(@leader)
    click_on "Edit this leader", match: :first

    fill_in "Brand", with: @leader.brand
    fill_in "Leader rating", with: @leader.leader_rating
    fill_in "Material", with: @leader.material
    fill_in "Name", with: @leader.name
    fill_in "Notes", with: @leader.notes
    fill_in "Price", with: @leader.price
    fill_in "Purchase date", with: @leader.purchase_date
    fill_in "User", with: @leader.user_id
    click_on "Update Leader"

    assert_text "Leader was successfully updated"
    click_on "Back"
  end

  test "should destroy Leader" do
    visit leader_url(@leader)
    accept_confirm { click_on "Destroy this leader", match: :first }

    assert_text "Leader was successfully destroyed"
  end
end
