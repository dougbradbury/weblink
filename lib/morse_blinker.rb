class MorseBlinker
  def initialize(led, tick)
    @led = led
    @tick = tick
  end
  
  def say(code)    
    code.each_byte do |char|
      case char
      when 46 # '.' 
        turn_on_for(1)
      when 45 # '-'
        turn_on_for(3)
      when 32 # ' '
        sleep 3*@tick
      end
    end  
  end
  
  def turn_on_for(ticks)
    @led.on
    sleep ticks*@tick
    @led.off
    sleep @tick
  end
end
