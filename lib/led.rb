class Led
  def initialize(options)
    @data_register = options[:data_register]
    @mask = options[:mask]
    @mmio = options[:mmio]
  end
  
  def on
    @mmio.write(@data_register,"w", current & ~@mask)
  end
  
  def off
    @mmio.write(@data_register,"w", current | @mask)
  end
  
  def on?
    current & @mask == 0
  end
  
  def current
    @mmio.read(@data_register,"w")
  end
  
end