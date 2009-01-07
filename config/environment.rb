$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
$: << File.expand_path(File.dirname(__FILE__) + "/../")
require 'rubygems'
require 'sinatra'
CONFIG = {}

configure :production do
  require 'leds_S3C2440A'
  require 'rack/handler/webrick'
  
  Sinatra::Application.default_options.merge!(
   :run => false,
   :env => :production,
   :port => 80
   )
end

configure :test do
  require 'mock_led'
  CONFIG[:data_dir] = Dir.tmpdir + "/weblink_test"
  Dir.mkdir(CONFIG[:data_dir]) unless File.exists?(CONFIG[:data_dir])
end

configure :development do
  require 'mock_led'
  CONFIG[:data_dir] = Dir.tmpdir + "/weblink_devlopment"
  Dir.mkdir(CONFIG[:data_dir]) unless File.exists?(CONFIG[:data_dir])
end
