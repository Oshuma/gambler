Gem::Specification.new do |s|
  s.name = %q{gambler}
  s.version = "0.0.2"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dale Campbell"]
  s.cert_chain = ["/Users/oshuma/.gem/gem-public_cert.pem"]
  s.date = %q{2008-06-09}
  s.default_executable = %q{gambler_client}
  s.description = %q{Ruby library to satisfy yet another human addiction.}
  s.email = ["dale@save-state.net"]
  s.executables = ["gambler_client"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README", "README.rdoc", "README.txt", "Rakefile", "bin/gambler_client", "lib/gambler.rb", "lib/gambler/card.rb", "lib/gambler/deck.rb", "lib/gambler/exceptions.rb", "lib/gambler/game.rb", "lib/gambler/game/basic_game.rb", "lib/gambler/game/blackjack.rb", "lib/gambler/player.rb", "tasks/ditz.rake", "tasks/docs.rake", "tasks/git.rake", "tasks/override_rake_task.rb", "tasks/rcov.rake", "tasks/site.rake", "tasks/util.rb", "test/game/test_basic_game.rb", "test/game/test_blackjack.rb", "test/helper.rb", "test/suite.rb", "test/test_card.rb", "test/test_deck.rb", "test/test_gambler.rb", "test/test_player.rb"]
  s.has_rdoc = true
  s.homepage = %q{Github:: http://github.com/Oshuma/gambler/}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gambler}
  s.rubygems_version = %q{1.1.1}
  s.signing_key = %q{/Users/oshuma/.gem/gem-private_key.pem}
  s.summary = %q{Ruby library to satisfy yet another human addiction.}
  s.test_files = ["test/game/test_basic_game.rb", "test/game/test_blackjack.rb", "test/test_card.rb", "test/test_deck.rb", "test/test_gambler.rb", "test/test_player.rb"]

  s.add_dependency(%q<hoe>, [">= 1.5.3"])
end
