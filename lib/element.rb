class Element
  extend Native::Helpers

  alias_native :add_class, :addClass
  alias_native :get_context, :getContext
  alias_native :show
  alias_native :hide
  alias_native :append_child, :appendChild
  alias_native :add_child, :appendChild

  def initialize(selector)
    @native = `document.querySelector(#{selector})`
  end
end
