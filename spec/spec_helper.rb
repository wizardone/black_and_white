$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('support/simplecov.rb', __dir__)
require File.expand_path('support/rspec.rb', __dir__)

if ENV['BAW_MONGOID']
  require 'mongoid'
  Mongoid.load!(File.expand_path('support/mongoid/mongoid.yml', __dir__), :test)
  Dir[[File.expand_path(__dir__), 'support/mongoid/**/*.rb'].join('/')].each { |f| require f }
elsif ENV['BAW_ACTIVERECORD']
  require 'active_record'
  require 'black_and_white/config'

  require 'black_and_white'
  require 'black_and_white/active_record/test'
  require 'black_and_white/active_record/error'
  require 'black_and_white/helpers/utils'
  Dir[[File.expand_path(__dir__), 'support/active_record/**/*.rb'].join('/')].each { |f| require f }
else
  # TODO: throw a proper error message
  raise "You must run the spec agains an ORM"
end
