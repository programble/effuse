Gem::Specification.new do |s|
  s.name = 'effuse'
  s.version = '2.0.1'
  s.authors = ['Curtis McEnroe']
  s.email = ['programble@gmail.com']
  s.homepage = 'https://github.com/programble/effuse'
  s.summary = 'Tool for symlinking dotfiles'
  s.description = s.summary

  s.files = `git ls-files`.split("\n")
  s.executables = 'effuse'
end
