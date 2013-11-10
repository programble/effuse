$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'effuse'

Gem::Specification.new do |s|
  s.name          = 'effuse'
  s.version       = Effuse::VERSION
  s.authors       = ['Curtis McEnroe']
  s.email         = ['programble@gmail.com']
  s.homepage      = 'https://github.com/programble/effuse'
  s.licenses      = ['ISC']
  s.summary       = 'Tool for symlinking dotfiles'
  s.description   = s.summary

  s.files         = `git ls-files`.split("\n")
  s.executables   = 'effuse'
  s.require_paths = ['lib']
end
