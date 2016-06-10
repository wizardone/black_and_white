require "black_and_white/version"
require "black_and_white/config"
require "black_and_white/hooks"

if defined?(::ActiveRecord)
  #require "black_and_white/active_record/participant"
  #require "black_and_white/active_record/test"
end
module BlackAndWhite

end

require "black_and_white/railtie" if defined?(Rails::Railtie)
