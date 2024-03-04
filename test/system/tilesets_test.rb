require "application_system_test_case"

class TilesetsTest < ApplicationSystemTestCase
  setup do
    @tileset = tilesets(:one)
  end

  test "visiting the index" do
    visit tilesets_url
    assert_selector "h1", text: "Tilesets"
  end

  test "should create tileset" do
    visit tilesets_url
    click_on "New tileset"

    fill_in "Name", with: @tileset.name
    fill_in "Tiles", with: @tileset.tiles
    fill_in "Tilesize", with: @tileset.tilesize
    click_on "Create Tileset"

    assert_text "Tileset was successfully created"
    click_on "Back"
  end

  test "should update Tileset" do
    visit tileset_url(@tileset)
    click_on "Edit this tileset", match: :first

    fill_in "Name", with: @tileset.name
    fill_in "Tiles", with: @tileset.tiles
    fill_in "Tilesize", with: @tileset.tilesize
    click_on "Update Tileset"

    assert_text "Tileset was successfully updated"
    click_on "Back"
  end

  test "should destroy Tileset" do
    visit tileset_url(@tileset)
    click_on "Destroy this tileset", match: :first

    assert_text "Tileset was successfully destroyed"
  end
end
