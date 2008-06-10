require 'rubygems'
require 'hoe'
require './lib/gambler'
require './tasks/override_rake_task'
require './tasks/util'

GAMBLER_ROOT = File.dirname(__FILE__) unless defined? GAMBLER_ROOT

Hoe.new('Gambler', Gambler::VERSION) do |g|
  g.developer('Dale Campbell', 'dale@save-state.net')
  g.name = 'gambler'
  g.version = Gambler::VERSION
  g.changes = g.paragraphs_of('History.txt', 0..1).join("\n\n")

  url = g.paragraphs_of('README.txt', 1).first.split(/\n/)[1].split[1].strip
  g.url = url

  g.summary = 'Ruby library to satisfy yet another human addiction.'
  g.description = g.paragraphs_of('README.txt', 3..3).join("\n\n")
end

# Remove un-needed tasks.
remove_task 'audit'
remove_task 'generate_key'
remove_task 'multi'
remove_task 'post_blog'

Dir["#{GAMBLER_ROOT}/tasks/**/*.rake"].sort.each { |task| load task }

task :default => [ :test, :rcov ]

namespace :gambler do
  desc 'Clean up dynamically generated files'
  task :cleanup do
    %w{
      docs:clear
      issues:report:clear
      rcov:clear
      site:clear_local
    }.each do |clean|
      Rake::Task[clean].invoke
    end
  end
end

desc 'Open a console with Gambler loaded'
task :console do
  sh "irb -rubygems -r ./lib/gambler.rb"
end
