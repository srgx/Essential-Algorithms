class TextField
  attr_reader :text, :symbol, :x, :y
  def initialize(text,x,y,symbol)
      @symbol = symbol
      @text, @x, @y = text, x, y
      @image = Rectangle.new(x: @x, y: @y, width: 200, height: 50, color: 'orange', z: 10)
      @textImage = Text.new(@text,x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def enter(le)
    @textImage.text += le
    @text += le
  end

  def delete
    @textImage.text = @textImage.text.chop
    @text.chop!
  end

  def click
    @image.color = 'green'
    return @symbol
  end

  def reset
    @image.color = 'orange'
  end

end
