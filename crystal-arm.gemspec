# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'sapphire-arm'
  s.version = '0.0.1'

  s.authors = ['Torsten Ruger']
  s.email = 'torsten@villataika.fi'
  s.extra_rdoc_files = ['README.markdown']
  s.files = %w(README.markdown LICENSE.txt Rakefile) + Dir.glob("lib/**/*")
  s.homepage = 'https://github.com/sapphire-vm/sapphire-arm'
  s.license = 'MIT'
  s.require_paths = ['lib']
  s.summary = 'Implementation of the sapphire virtual vm in arm v6 opcodes'  
  
  s.add_dependency 'sapphire', '~> 0.0.1'
end
