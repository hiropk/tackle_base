require "application_system_test_case"

class LinesTest < ApplicationSystemTestCase
  setup do
    @line = lines(:one)
  end

  test "visiting the index" do
    visit lines_url
    assert_selector "h1", text: "Lines"
  end

  test "should create line" do
    visit lines_url
    click_on "New line"

    fill_in "Brand", with: @line.brand
    fill_in "Length", with: @line.length
    check "Marker" if @line.marker
    fill_in "Name", with: @line.name
    fill_in "Notes", with: @line.notes
    fill_in "Pe rating", with: @line.pe_rating
    fill_in "Price", with: @line.price
    fill_in "Purchase date", with: @line.purchase_date
    fill_in "Strand count", with: @line.strand_count
    fill_in "User", with: @line.user_id
    click_on "Create Line"

    assert_text "Line was successfully created"
    click_on "Back"
  end

  test "should update Line" do
    visit line_url(@line)
    click_on "Edit this line", match: :first

    fill_in "Brand", with: @line.brand
    fill_in "Length", with: @line.length
    check "Marker" if @line.marker
    fill_in "Name", with: @line.name
    fill_in "Notes", with: @line.notes
    fill_in "Pe rating", with: @line.pe_rating
    fill_in "Price", with: @line.price
    fill_in "Purchase date", with: @line.purchase_date
    fill_in "Strand count", with: @line.strand_count
    fill_in "User", with: @line.user_id
    click_on "Update Line"

    assert_text "Line was successfully updated"
    click_on "Back"
  end

  test "should destroy Line" do
    visit line_url(@line)
    accept_confirm { click_on "Destroy this line", match: :first }

    assert_text "Line was successfully destroyed"
  end
end
