require "black_and_white/version"
require "black_and_white/config"

module BlackAndWhite
 # if defined?(ActiveRecord)
 #   require 'black_and_white/active_record'
 # elsif defined?(Mongoid)
 #   require 'black_and_white/mongoid.rb'
 # else
 #   raise 'Black and White is designed to work with ActiveRecord or Mongoid.'
 # end

  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end
end
