$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'black_and_white'
# Find gem root path
Dir[[File.expand_path('../', __FILE__), 'support/**/*.rb'].join('/')].each { |f| require f }

RSpec.configure do |config|
end
