# Tasks to handle application docs.
DOC_TITLE = "Gambler v#{Gambler::VERSION} Documentation"
DOC_ROOT  = File.join(GAMBLER_ROOT, 'doc') unless defined? DOC_ROOT
API_DOCS  = File.join(DOC_ROOT, 'api')

# Remove the default Hoe documentation tasks.
remove_task 'clobber_docs'
remove_task 'docs'
remove_task 'docs/index.html'
remove_task 'publish_docs'
remove_task 'redocs'
remove_task 'ridocs'

desc 'Generate the Gambler API docs'
task :docs do
  Rake::Task['docs:api'].invoke
end

namespace :docs do
  task :setup_rdoc do
    @file_list = FileList[ "#{GAMBLER_ROOT}/README",
                           "#{GAMBLER_ROOT}/lib/**/*.rb",
                           "#{GAMBLER_ROOT}/bin/gambler_client" ]
    @file_list.add "#{GAMBLER_ROOT}/test/**/*.rb" if ENV['TESTS']
    # Substitute GAMBLER_ROOT with a dot.  Makes for a better index in the generated docs.
    @files = @file_list.collect  {|f| f.gsub(/#{GAMBLER_ROOT}/, '.')}
    @options = %W[
      --all
      --inline-source
      --line-numbers
      --main README
      --op #{API_DOCS}
      --title '#{DOC_TITLE}'
    ]
    # Generate a diagram, yes/no?
    @options << '-d' if RUBY_PLATFORM !~ /win32/ && `which dot` =~ /\/dot/ && !ENV['NODOT']
  end

  # desc 'Generate the Gambler API docs'
  task :api => [ :setup_rdoc ] do
    run_rdoc(@options, @files)
    system("open #{API_DOCS}/index.html") if RUBY_PLATFORM =~ /darwin/ && ENV['OPEN']
  end

  desc 'Remove the Gambler API docs'
  task :clear do
    system("rm -rf #{API_DOCS}")
  end

  desc 'Remove and rebuild the Gambler API docs'
  task :rebuild do
    Rake::Task['docs:clear'].invoke
    Rake::Task['docs:api'].invoke
  end
end

private

# Runs rdoc with the given +options+ and +files+.
# Both arguments should be an Array, which is joined with a space.
def run_rdoc(options, files)
  options = options.join(' ') if options.is_a? Array
  files   = files.join(' ')   if files.is_a? Array
  system("rdoc #{options} #{files}")
end
