# Tasks for dealing with the RubyForge site.

# The local directories to store the website files.
LOCAL_SITE     = File.join("#{DOC_ROOT}", 'rubyforge.site')
SITE_COVERAGE = File.join(LOCAL_SITE, 'coverage')
SITE_API      = File.join(LOCAL_SITE, 'api')

# The remote directory the files will be scp'ed to.
REMOTE_SITE = 'gambler.rubyforge.org:/var/www/gforge-projects/gambler'

# A list of static pages to upload.
PAGES = %w{
  index.html
  robots.txt
}

namespace :site do
  desc 'Clear the local site directory of dynamic files'
  task :clear_local do
    header("Clearing local site directory: #{LOCAL_SITE}")
    FileUtils.rm_f  SITE_API      if File.exists? SITE_API
    # FileUtils.mkdir SITE_API
    FileUtils.rm_r  SITE_COVERAGE if File.exists? SITE_COVERAGE
    # FileUtils.mkdir SITE_COVERAGE
  end

  # Copies the issue and docs to the site directory.
  task :setup_site_dir => [ :clear_local, 'docs:api', 'rcov:html' ] do
    header('Copying coverage and API docs to the site directory.')
    FileUtils.cp_r(COVERAGE_DIR, LOCAL_SITE)
    FileUtils.cp_r(API_DOCS, LOCAL_SITE)
  end

  desc 'Upload the issues and docs to the website'
  task :upload => :setup_site_dir do
    header('Uploading local site to remote site.')
    sh "cd #{LOCAL_SITE} && scp -r ./* #{REMOTE_SITE}"
  end
end
