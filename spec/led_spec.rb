require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'led'

describe Led do
  before(:each) do
    @mock_mmio = mock("mmio", :read => nil, :write => nil)
    @led = Led.new(:data_register => 0x40014232, :mask => 0x00000001, :mmio => @mock_mmio)
  end

  it "should turn on" do
    @mock_mmio.should_receive(:read).with(0x40014232, "w").and_return(0xFF45FFFF)
    @mock_mmio.should_receive(:write).with(0x40014232, "w", 0xFF45FFFE)
    @led.on
  end
  
  it "should turn off" do
    @mock_mmio.should_receive(:read).with(0x40014232, "w").and_return(0xFFFFFFFE)
    @mock_mmio.should_receive(:write).with(0x40014232, "w", 0xFFFFFFFF)
    @led.off
  end
  
  it "should be on" do
    @mock_mmio.should_receive(:read).with(0x40014232, "w").and_return(0xFFFFFFFE)
    @led.should be_on
  end
  
  it "should not be on" do
    @mock_mmio.should_receive(:read).with(0x40014232, "w").and_return(0xFFFFFFFF)
    @led.should_not be_on
  end
end
