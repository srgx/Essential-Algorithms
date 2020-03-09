# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080


Square.new(
  x: 600, y: 200,
  size: 125,
  color: 'red',
  z: 10
)

Text.new(
  'Load',
  x: 150, y: 470,
  # font: 'vera.ttf',
  size: 20,
  color: 'blue',
  # rotate: 90,
  z: 10
)

Text.new(
  'Save',
  x: 450, y: 470,
  # font: 'vera.ttf',
  size: 20,
  color: 'blue',
  # rotate: 90,
  z: 10
)

fileContent = File.read('test.ntw')


Text.new(
  fileContent,
  x: 750, y: 470,
  # font: 'vera.ttf',
  size: 20,
  color: 'blue',
  # rotate: 90,
  z: 10
)

show
