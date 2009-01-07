require 'mmio'
require 'led'

class MemoryObject
  include MemoryMappedIO
end

class Led
  def self.find(id)
    if id == "1"
      return Led.new(:data_register => 0x56000014, :mask => 0x00000001, :mmio => MemoryObject.new)
    elsif id == "2"
      return Led.new(:data_register => 0x56000014, :mask => 0x00000002, :mmio => MemoryObject.new)
    else
      return nil
    end
  end
end

mmio = MemoryObject.new
control_reg = mmio.read(0x56000010, "w")
mmio.write(0x56000010, "w", ((control_reg & 0xFFFFFFF0) | 0x00000005))