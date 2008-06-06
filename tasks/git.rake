# A few helpful tasks for dealing with git.

# Some defaults.
REPOS  = ENV['REPOS']  || 'github,rubyforge'
BRANCH = ENV['BRANCH'] || 'master'

namespace :git do
  desc 'Mirror the local repo on REPOS (comma delimited)'
  task :mirror do
    repos.each do |repo|
      sh "git push --mirror #{repo}"
    end
  end

  desc 'Push BRANCH to REPOS (comma delimited)'
  task :push do
    repos.each do |repo|
      sh "git push #{repo} #{BRANCH}"
    end
  end
end

private

def repos
  REPOS.split(',')
end
