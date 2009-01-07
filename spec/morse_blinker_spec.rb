require File.dirname(__FILE__) + '/spec_helper'

require 'morse_blinker'
require 'stopwatch'

class TimedLed
  def initialize
    @stopwatch = Stopwatch.new
  end
  
  def on
    @stopwatch.start_stop
  end
  
  def off
    @stopwatch.start_stop
  end
  
  def on_time
    return @stopwatch.elapsed
  end

end


describe MorseBlinker do
  before(:each) do
    @led = mock("led", :on => nil, :off => nil)
    @blinker = MorseBlinker.new(@led, 0.001)
  end
  
  it "should blink a dot" do
    @led.should_receive(:on).once
    @led.should_receive(:off).once
    @blinker.say(".")
  end
  
  it "should blink two dots" do
    @led.should_receive(:on).twice
    @led.should_receive(:off).twice
    @blinker.say("..")    
  end
  
  it "should not blink for a space" do
    @led.should_receive(:on).twice
    @led.should_receive(:off).twice
    @blinker.say(" . . ")        
  end
end
describe MorseBlinker do
  before(:each) do
    @led = TimedLed.new
    @blinker = MorseBlinker.new(@led, 0.01)
    @stopwatch = Stopwatch.new
  end

  it "should stay on for one tick on a ." do
    @blinker.say(".")
    @led.on_time.should be > 0.01
    @led.on_time.should be < 0.02
  end
  
  it "should stay on for three ticks for a -" do
    @blinker.say("-")
    @led.on_time.should be > 0.03
    @led.on_time.should be < 0.04
  end
  
  it "should stay off for one tick between after a ." do
    @stopwatch.time do
      @blinker.say(".")
    end
    
    (@stopwatch.elapsed - @led.on_time).should be > 0.01
    (@stopwatch.elapsed - @led.on_time).should be < 0.02
  end
  
  it "should stay off for one tick between after a -" do
    @stopwatch.time do
      @blinker.say("-")
    end
    
    (@stopwatch.elapsed - @led.on_time).should be > 0.01
    (@stopwatch.elapsed - @led.on_time).should be < 0.02
  end
  
  it "should stay off for three thicks between different characters" do
    @stopwatch.time do
      @blinker.say(" ")
    end
    @led.on_time.should == 0
    @stopwatch.elapsed.should be > 0.03
    @stopwatch.elapsed.should be < 0.04
  end
  
  it "should stay off for 6 ticks for two spaces " do
    @stopwatch.time do
      @blinker.say("  ")
    end
    @led.on_time.should == 0
    @stopwatch.elapsed.should be > 0.06
    @stopwatch.elapsed.should be < 0.07
    
  end
end
