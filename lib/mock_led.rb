require 'yaml'

class MockLed
  def initialize(id=1)
    @id = id
  end
  
  def on
    @on = true
    save
  end
  
  def off
    @on = false
    save
  end
  
  def on?
    @on
  end  
  
  def save
    File.open(CONFIG[:data_dir] + "/led#{@id}.yaml", "w") do |file|
      file.write YAML::dump(self)
    end
  end
  
end

class Led
  def self.find(id)
    if File.exists?(CONFIG[:data_dir] + "/led#{id}.yaml")
      return YAML::load(File.open(CONFIG[:data_dir] + "/led#{id}.yaml", "r"))
    else
      return MockLed.new(id)
    end
  end
end
