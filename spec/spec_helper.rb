$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('support/simplecov.rb', __dir__)
require File.expand_path('support/rspec.rb', __dir__)
require 'byebug'
if ENV['BAW_MONGOID']
  require 'mongoid'
  require 'black_and_white'
  Mongoid.load!(File.expand_path('support/mongoid/mongoid.yml', __dir__), :test)
  Dir[[File.expand_path(__dir__), 'support/mongoid/**/*.rb'].join('/')].each { |f| require f }

  BlackAndWhite::Helpers::Broker.register(:mongoid)
elsif ENV['BAW_ACTIVERECORD']
  require 'black_and_white'
  require 'black_and_white/active_record/test'
  Dir[[File.expand_path(__dir__), 'support/active_record/**/*.rb'].join('/')].each { |f| require f }

  BlackAndWhite::Helpers::Broker.register(:active_record)
else
  # TODO: throw a proper error message
  raise "You must run the spec agains an ORM"
end
