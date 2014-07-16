# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'kide-arm'
  s.version = '0.0.1'

  s.authors = ['Torsten Ruger']
  s.email = 'torsten@villataika.fi'
  s.extra_rdoc_files = ['README.markdown']
  s.files = %w(README.markdown LICENSE.txt Rakefile) + Dir.glob("lib/**/*")
  s.homepage = 'https://github.com/kide-vm/kide-arm'
  s.license = 'MIT'
  s.require_paths = ['lib']
  s.summary = 'Implementation of the kide virtual vm in arm v6 opcodes'  
  
  s.add_dependency 'kide', '~> 0.0.1'
end
