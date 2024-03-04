require "test_helper"

class TilesetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tileset = tilesets(:one)
  end

  test "should get index" do
    get tilesets_url
    assert_response :success
  end

  test "should get new" do
    get new_tileset_url
    assert_response :success
  end

  test "should create tileset" do
    assert_difference("Tileset.count") do
      post tilesets_url, params: { tileset: { name: @tileset.name, tiles: @tileset.tiles, tilesize: @tileset.tilesize } }
    end

    assert_redirected_to tileset_url(Tileset.last)
  end

  test "should show tileset" do
    get tileset_url(@tileset)
    assert_response :success
  end

  test "should get edit" do
    get edit_tileset_url(@tileset)
    assert_response :success
  end

  test "should update tileset" do
    patch tileset_url(@tileset), params: { tileset: { name: @tileset.name, tiles: @tileset.tiles, tilesize: @tileset.tilesize } }
    assert_redirected_to tileset_url(@tileset)
  end

  test "should destroy tileset" do
    assert_difference("Tileset.count", -1) do
      delete tileset_url(@tileset)
    end

    assert_redirected_to tilesets_url
  end
end
