require 'rubygems'
require 'hoe'
require './lib/gambler.rb'

GAMBLER_ROOT = File.dirname(__FILE__) unless defined? GAMBLER_ROOT

Dir["#{GAMBLER_ROOT}/tasks/**/*.rake"].sort.each { |task| load task }

Hoe.new('gambler', Gambler::VERSION) do |g|
  g.developer('Dale Campbell', 'dale@save-state.net')
  g.name = 'Gambler'
  g.version = Gambler::VERSION
end

desc 'Open a console with Gambler loaded'
task :console do
  sh "irb -rubygems -r ./lib/gambler.rb"
end