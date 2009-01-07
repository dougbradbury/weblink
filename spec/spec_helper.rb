$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
$: << File.expand_path(File.dirname(__FILE__) + "/../")
$: << File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'spec'
require 'sinatra'
require 'sinatra/test/rspec'

require 'tmpdir'
CONFIG = {}
CONFIG[:data_dir] = Dir.tmpdir + "/weblink_test_data"
Dir.mkdir(CONFIG[:data_dir]) unless File.exists?(CONFIG[:data_dir])