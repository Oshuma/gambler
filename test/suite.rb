require 'text/unit'

Dir["#{File.dirname(__FILE__)}/test_*.rb"].each do |test|
  require test
end
