require "application_system_test_case"

class LogsTest < ApplicationSystemTestCase
  setup do
    @log = logs(:one)
  end

  test "visiting the index" do
    visit logs_url
    assert_selector "h1", text: "Logs"
  end

  test "should create log" do
    visit logs_url
    click_on "New log"

    fill_in "Area", with: @log.area
    fill_in "End time", with: @log.end_time
    fill_in "Fishing date", with: @log.fishing_date
    fill_in "Fishing guide boat", with: @log.fishing_guide_boat
    fill_in "Menu", with: @log.menu
    fill_in "Notes", with: @log.notes
    fill_in "Other", with: @log.other
    fill_in "Start time", with: @log.start_time
    click_on "Create Log"

    assert_text "Log was successfully created"
    click_on "Back"
  end

  test "should update Log" do
    visit log_url(@log)
    click_on "Edit this log", match: :first

    fill_in "Area", with: @log.area
    fill_in "End time", with: @log.end_time.to_s
    fill_in "Fishing date", with: @log.fishing_date
    fill_in "Fishing guide boat", with: @log.fishing_guide_boat
    fill_in "Menu", with: @log.menu
    fill_in "Notes", with: @log.notes
    fill_in "Other", with: @log.other
    fill_in "Start time", with: @log.start_time.to_s
    click_on "Update Log"

    assert_text "Log was successfully updated"
    click_on "Back"
  end

  test "should destroy Log" do
    visit log_url(@log)
    accept_confirm { click_on "Destroy this log", match: :first }

    assert_text "Log was successfully destroyed"
  end
end
