$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start do
  add_filter '../lib/black_and_white/hooks.rb'
  add_filter 'support/'
end
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require 'active_record'
require 'black_and_white/config'

require 'black_and_white'
require 'black_and_white/active_record/test'
require 'black_and_white/active_record/error'
require 'black_and_white/helpers/utils'

# Find gem root path
Dir[[File.expand_path('../', __FILE__), 'support/**/*.rb'].join('/')].each { |f| require f }
