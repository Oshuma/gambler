Gem::Specification.new do |s|
  s.name = %q{gambler}
  s.version = "0.0.2"
  s.date = %q{2008-06-09}

  s.authors = ["Dale Campbell"]
  s.email = ["dale@save-state.net"]
  s.homepage = %q{http://gambler.rubyforge.org/}

  s.summary = %q{Ruby library to satisfy yet another human addiction.}
  s.description = %q{Gambler is a Ruby library which can be included into other classes/modules. It provides an object oriented interface for common gambling games such as Blackjack, Poker, etc.}

  s.require_paths = ["lib"]
  s.files = ["History.txt", "Manifest.txt", "README", "README.rdoc", "README.txt", "Rakefile", "bin/gambler_client", "lib/gambler.rb", "lib/gambler/card.rb", "lib/gambler/deck.rb", "lib/gambler/exceptions.rb", "lib/gambler/game.rb", "lib/gambler/game/basic_game.rb", "lib/gambler/game/blackjack.rb", "lib/gambler/player.rb", "tasks/ditz.rake", "tasks/docs.rake", "tasks/git.rake", "tasks/override_rake_task.rb", "tasks/rcov.rake", "tasks/site.rake", "tasks/util.rb", "test/game/test_basic_game.rb", "test/game/test_blackjack.rb", "test/helper.rb", "test/suite.rb", "test/test_card.rb", "test/test_deck.rb", "test/test_gambler.rb", "test/test_player.rb"]
  s.test_files = ["test/game/test_basic_game.rb", "test/game/test_blackjack.rb", "test/test_card.rb", "test/test_deck.rb", "test/test_gambler.rb", "test/test_player.rb"]

  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
end
