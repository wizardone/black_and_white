require "black_and_white/version"
require "black_and_white/config"
require "black_and_white/hooks"
require "black_and_white/active_record"

module BlackAndWhite
  def self.participate(ab_test, object, &block)
  end
end

require "black_and_white/railtie" if defined?(Rails::Railtie)
