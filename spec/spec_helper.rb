$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_record'
require 'black_and_white/config'

# Find gem root path
Dir[[File.expand_path('../', __FILE__), 'support/**/*.rb'].join('/')].each { |f| require f }

require 'black_and_white'
# Fire the hooks that require the models and then tell
# ActiveRecord to load them
BlackAndWhite::Hooks.init
ActiveSupport.run_load_hooks(:active_record, ActiveRecord::Base)
