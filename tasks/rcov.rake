# Tasks to handle rcov usage.

DOC_ROOT     = File.join(GAMBLER_ROOT, 'doc') unless defined? DOC_ROOT
COVERAGE_DIR = File.join(DOC_ROOT, 'coverage')

desc 'Display coverage stats'
task :rcov do
  Rake::Task['rcov:stats'].invoke
end

namespace :rcov do
  task :setup_rcov do
    @file_list = FileList["#{GAMBLER_ROOT}/test/**/test_*.rb"]
    @test_files = @file_list.collect { |f| f.gsub(/#{GAMBLER_ROOT}/, '.')}
    @options = [
      # Remove rcov.rb from report. Escape the slash, because we need it in the string.
      "-x 'rcov\\.rb'",
      "-o #{COVERAGE_DIR}"
    ]
  end

  desc 'Remove the generated coverage report'
  task :clear do
    system("rm -rf #{COVERAGE_DIR}")
  end

  desc 'Generate coverage report'
  task :html => [ :clear, :setup_rcov ] do
    @options << '--text-summary'
    run_rcov(@options, @test_files)
    system("open #{COVERAGE_DIR}/index.html") if RUBY_PLATFORM =~ /darwin/ && ENV['OPEN']
  end

  task :stats => [ :setup_rcov ] do
    @options << '--text-report --no-html'
    run_rcov(@options, @test_files)
  end
end

private

# Runs rcov with the given +options+ and +test_files+.
# Both arguments should be an Array, which is joined with a space.
def run_rcov(options, test_files)
  options    = options.join(' ')    if options.is_a?    Array
  test_files = test_files.join(' ') if test_files.is_a? Array
  system("rcov #{options} #{test_files}")
end
