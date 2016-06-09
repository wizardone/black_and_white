require "black_and_white/version"
require "black_and_white/config"

module BlackAndWhite

  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end

  if defined?(::ActiveRecord)
    require "black_and_white/active_record/participant"
  end
end
