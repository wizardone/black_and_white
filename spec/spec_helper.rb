$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('support/simplecov.rb', __dir__)
require File.expand_path('support/rspec.rb', __dir__)

require 'black_and_white/config'
require 'black_and_white/hooks'

if ENV['BAW_MONGOID']
  require 'mongoid'
  Mongoid.load!(File.expand_path('support/mongoid/mongoid.yml', __dir__), :test)
  Mongoid.raise_not_found_error = false

  BlackAndWhite::Hooks.init
  Dir[[File.expand_path(__dir__), 'support/mongoid/**/*.rb'].join('/')].each { |f| require f }
elsif ENV['BAW_ACTIVERECORD']
  require 'active_record'

  BlackAndWhite::Hooks.init
  Dir[[File.expand_path(__dir__), 'support/active_record/**/*.rb'].join('/')].each { |f| require f }
else
  # TODO: throw a proper error message
  raise "You must run the spec agains an ORM"
end
