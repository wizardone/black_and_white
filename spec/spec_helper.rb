$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coveralls'
Coveralls.wear!

require 'active_record'
require 'black_and_white/config'

require 'black_and_white'
require 'black_and_white/active_record/participant'
require 'black_and_white/active_record/test'
require 'black_and_white/active_record/error'
require 'black_and_white/helpers/utils'

# Find gem root path
Dir[[File.expand_path('../', __FILE__), 'support/**/*.rb'].join('/')].each { |f| require f }
