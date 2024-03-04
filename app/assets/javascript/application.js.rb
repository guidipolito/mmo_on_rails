# Entry point for the build script in your package.json
require 'opal'
require 'pixi/pixi'
require 'opal-jquery'
require 'grid'

def exists(selector)
  Document.ready? do
    yield if block_given? && Document.find(selector).length > 0
  end
end
require 'map_editor'
require 'tileset_editor'
