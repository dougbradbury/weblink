require File.dirname(__FILE__) + '/spec_helper'
require 'weblink'

describe "Weblink" do
  it "should show index" do
    get_it '/'
    @response.should be_ok
    @response.body.should include("Turn On")
  end
end
