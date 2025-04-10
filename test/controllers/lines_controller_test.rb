require "test_helper"

class LinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line = lines(:one)
  end

  test "should get index" do
    get lines_url
    assert_response :success
  end

  test "should get new" do
    get new_line_url
    assert_response :success
  end

  test "should create line" do
    assert_difference("Line.count") do
      post lines_url, params: { line: { brand: @line.brand, length: @line.length, marker: @line.marker, name: @line.name, notes: @line.notes, pe_rating: @line.pe_rating, price: @line.price, purchase_date: @line.purchase_date, strand_count: @line.strand_count, user_id: @line.user_id } }
    end

    assert_redirected_to line_url(Line.last)
  end

  test "should show line" do
    get line_url(@line)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_url(@line)
    assert_response :success
  end

  test "should update line" do
    patch line_url(@line), params: { line: { brand: @line.brand, length: @line.length, marker: @line.marker, name: @line.name, notes: @line.notes, pe_rating: @line.pe_rating, price: @line.price, purchase_date: @line.purchase_date, strand_count: @line.strand_count, user_id: @line.user_id } }
    assert_redirected_to line_url(@line)
  end

  test "should destroy line" do
    assert_difference("Line.count", -1) do
      delete line_url(@line)
    end

    assert_redirected_to lines_url
  end
end
