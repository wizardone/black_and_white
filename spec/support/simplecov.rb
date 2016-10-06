require 'simplecov'
SimpleCov.start do
  add_filter '../lib/black_and_white/hooks.rb'
  add_filter 'support/'
end
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
