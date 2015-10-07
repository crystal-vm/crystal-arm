# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'salama-arm'
  s.version = '0.3.0'

  s.authors = ['Torsten Ruger']
  s.email = 'torsten@villataika.fi'
  s.extra_rdoc_files = ['README.md']
  s.files = %w(README.md LICENSE) + Dir.glob("lib/**/*")
  s.homepage = 'https://github.com/salama/salama-arm'
  s.license = 'MIT'
  s.require_paths = ['lib']
  s.summary = 'Implementation of the salama virtual vm in arm v6 opcodes'
end
