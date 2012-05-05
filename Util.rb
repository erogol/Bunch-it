class Util3
  attr_accessor :thing
  def initialize(attributes = {})
    @thing = attributes[:thing]
  end
  
  def shuffleString
    puts thing.split('').shuffle.join('')
  end
end

c = Util3.new({:thing => "anan nereli"})

c.shuffleString
