require 'webmock/rspec'
require "nokogiri"
require "byebug"
WebMock.disable_net_connect!(allow_localhost: true)

RSPEC_ROOT = File.dirname __FILE__