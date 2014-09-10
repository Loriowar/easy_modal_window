# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_modal_window/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_modal_window"
  spec.version       = EasyModalWindow::VERSION
  spec.authors       = ["Ivan Zabrovskiy"]
  spec.email         = ["loriowar@gmail.com"]
  spec.summary       = %q{Small wrapper for jQuery-UI Dialog}
  spec.description   = %q{This is wrapper for jQuery-UI Dialog. Additionaly it contain several templates for render errors from ActiveRecord and ErrorMessagesContainer.}
  spec.homepage      = "https://github.com/Loriowar/easy_modal_window.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
