require 'rubygems'
require 'hoe'
require './lib/gambler.rb'

Hoe.new('gambler', Gambler::VERSION) do |g|
  g.developer('Dale Campbell', 'dale@save-state.net')
  g.name = 'Gambler'
  g.version = Gambler::VERSION
end

desc 'Open a console with Gambler loaded'
task :console do
  sh "irb -rubygems -r ./lib/grit.rb"
end

desc 'Run rcov coverage'
task :coverage do
  system("rm -fr coverage")
  system("rcov test/test_*.rb")
  # system("open coverage/index.html")
end
