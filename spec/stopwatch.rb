class Stopwatch
  
  def initialize 
    @elapsed_time = 0
    @start_time = nil
    @lap_time = 0
  end
  
  def elapsed
    return @elapsed_time
  end
  
  def reset
    @elapsed_time = 0 
  end
  
  def start_stop
    time = Time.now
    
    if not @start_time
      @start_time = time
    else
      @lap_time = time - @start_time
      @elapsed_time += @lap_time
      @start_time = nil
    end
  end
  
  def time(message = "duration")
    start_stop
    value = yield
    start_stop
    # puts "#{message}: #{@lap_time}"
    return value
  end
  
  def lap
    start_stop
    yield(@lap_time) if block_given?
    start_stop
    return @lap_time
  end
  
  def lap_print(message="Lap time")
    lap {|lap_time| Kernel.puts "===STOPWATCH LAP TIME=== #{message}: #{lap_time}"}
  end
  
  def elapsed_print(message="Elapsed time")
    Kernel.puts "===STOPWATCH ELAPSED TIME=== #{message}: #{@elapsed_time}"
  end
  
  
end
