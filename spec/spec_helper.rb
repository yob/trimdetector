require "rubygems"
require "bundler"
Bundler.setup

require 'rspec'
require 'pdf/reader'
require 'pdf/trim_detector'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.include TrimSpecHelper
end
