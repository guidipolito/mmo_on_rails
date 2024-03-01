require 'native'
module PIXI
  class Movable
    extend Native::Helpers
    native_accessor :x
    native_accessor :y
    native_accessor :rotation
    native_accessor :scale
    native_accessor :width
    native_accessor :height
    attr_reader :native
  end
end
require_relative 'rectangle'
require_relative 'texture'
require_relative 'sprite'
require_relative 'container'
require_relative 'application'
require_relative 'text'
