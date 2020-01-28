# Exercise 11

class PlanetSentinel
  attr_reader :nexts
  def initialize
    @nexts=Hash.new
  end
end

class Planet < PlanetSentinel
  attr_reader :properties
  def initialize(name,distance,mass,diameter)
    super()
    @properties={name:name,distance_to_sun:distance,mass:mass,diameter:diameter}
  end
end


def orderPlanetBy(sentinel,planet,property)
  s=sentinel
  while((nxt=s.nexts[property])!=nil&&
         nxt.properties[property]<planet.properties[property])
    s=nxt
  end
  planet.nexts[property]=nxt
  s.nexts[property]=planet
end


def addPlanetToList(sentinel,planet)
  orderPlanetBy(sentinel,planet,:mass)
  orderPlanetBy(sentinel,planet,:diameter)
  orderPlanetBy(sentinel,planet,:distance_to_sun)
end


planetSentinel=PlanetSentinel.new


planets=[["Uranus",7,5,6],["Venus",2,3,3],["Earth",3,4,4],
         ["Mars",4,2,2],["Mercury",1,1,1],["Saturn",6,7,7],
         ["Jupiter",5,8,8],["Neptune",8,6,5]]

planets.each { |p| addPlanetToList(planetSentinel,Planet.new(p[0],p[1],p[2],p[3])) }


def showPlanetsBy(sentinel,property,label)
  puts "-------------------------"
  puts label
  puts "-------------------------"
  s,c=sentinel,1
  while((nxt=s.nexts[property])!=nil)
    puts "#{c}. #{nxt.properties[:name]}"
    s=nxt
    c+=1
  end
end

=begin
showPlanetsBy(planetSentinel,:distance_to_sun,"Distance")
showPlanetsBy(planetSentinel,:mass,"Mass")
showPlanetsBy(planetSentinel,:diameter,"Diameter")
=end
