class Button
  attr_accessor :x, :y, :text, :symbol
  def initialize(text,x,y,symbol)
      @symbol = symbol
      @text, @x, @y, @color = text, x, y, 'red'
      @image = Rectangle.new(x: @x, y: @y,width: 200, height: 30, color: @color, z: 10)
      Text.new(@text, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def click
    if([:new,:oneway,:twoway,:depthfirst,:breadthfirst,:spanningtree,:minspanningtree,:path,:labsetpath,:labcorpath,:labsettree,:labcortree].include?(@symbol))
      @image.color='green'
    end
    return @symbol
  end

  def reset
    @image.color = 'red'
  end
end
