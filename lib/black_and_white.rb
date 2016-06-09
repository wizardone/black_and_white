require "black_and_white/version"
require "black_and_white/config"
if defined?(::ActiveRecord)
  require "black_and_white/active_record/participant"
  require "black_and_white/active_record/test"
end
# Load activerecord models after rails initialization process
# The gem code is loaded before that!!!
module BlackAndWhite

end
