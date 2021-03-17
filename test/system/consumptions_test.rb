require "application_system_test_case"

class ConsumptionsTest < ApplicationSystemTestCase
  setup do
    @consumption = consumptions(:one)
  end

  test "visiting the index" do
    visit consumptions_url
    assert_selector "h1", text: "Consumptions"
  end

  test "creating a Consumption" do
    visit consumptions_url
    click_on "New Consumption"

    click_on "Create Consumption"

    assert_text "Consumption was successfully created"
    click_on "Back"
  end

  test "updating a Consumption" do
    visit consumptions_url
    click_on "Edit", match: :first

    click_on "Update Consumption"

    assert_text "Consumption was successfully updated"
    click_on "Back"
  end

  test "destroying a Consumption" do
    visit consumptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Consumption was successfully destroyed"
  end
end
