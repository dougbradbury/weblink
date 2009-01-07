require File.expand_path(File.dirname(__FILE__) + "/config/environment")
require 'led'
require 'morse_blinker'
require 'morse'

get "/" do
  @led1 = Led.find("1")
  @led2 = Led.find("2")
  erb :index
end

get "/on/:id" do
  Led.find(params[:id]).on
  redirect '/'
end

get "/off/:id" do
  Led.find(params[:id]).off
  redirect '/'
end

post "/say/:id" do
  led = Led.find(params[:id])
  blinker = MorseBlinker.new(led, params[:speed].to_f)
  @message = Morse.encode(params[:message])
   Process.detach fork {blinker.say(@message)}
  "Saying #{@message} <a href='/'>Back</a>"
end

configure :production do
  Rack::Handler::WEBrick.run Sinatra.application  
end