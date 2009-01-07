require File.dirname(__FILE__) + '/spec_helper'
require 'mock_led'

describe MockLed do
  before(:each) do
    @led = MockLed.new
  end
  it "should turn on" do
    @led.on
    @led.should be_on
  end
  
  it "should turn off" do
    @led.off
    @led.should_not be_on
  end
  
  it "should create an Led" do
    Led.find(1).should be_is_a(MockLed)
  end
  
  it "should save the Led" do
    Led.find(1).on
    Led.find(1).should be_on
  end
  
  it "should save the led off" do
    Led.find(1).off
    Led.find(1).should_not be_on    
  end
  
  it "should save two leds" do
    Led.find(1).on
    Led.find(2).off
    Led.find(1).should be_on
    Led.find(2).should_not be_on
  end
end
