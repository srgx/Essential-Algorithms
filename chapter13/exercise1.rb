require_relative 'includes/button.rb'
require_relative 'includes/link.rb'
require_relative 'includes/node.rb'
require_relative 'includes/textField.rb'
require_relative 'includes/state.rb'

# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080


state = State.new

on :mouse_down do |event|
  case event.button
  when :left
    state.click(event.x,event.y)
  when :middle
    #
  when :right
    state.resetMode
    state.resetItems
    state.resetTemp
  end
end

on :key_down do |event|
  state.key(event.key)
end

show
