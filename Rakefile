require 'rubygems'
require 'hoe'
require './lib/gambler'
require './tasks/override_rake_task'
require './tasks/util'

GAMBLER_ROOT = File.dirname(__FILE__) unless defined? GAMBLER_ROOT

Hoe.new('gambler', Gambler::VERSION) do |g|
  g.developer('Dale Campbell', 'dale@save-state.net')
  g.name = 'Gambler'
  g.version = Gambler::VERSION
end

# Remove un-needed tasks.
remove_task 'audit'
remove_task 'generate_key'
remove_task 'multi'
remove_task 'post_blog'

Dir["#{GAMBLER_ROOT}/tasks/**/*.rake"].sort.each { |task| load task }

task :default => [ :test, :rcov ]

desc 'Open a console with Gambler loaded'
task :console do
  sh "irb -rubygems -r ./lib/gambler.rb"
end
