require "black_and_white/version"
require "black_and_white/config"
require "black_and_white/active_record"
require "black_and_white/active_record/error"
require "black_and_white/helpers/utils"
require "black_and_white/helpers/broker"
require "black_and_white/hooks"

require 'black_and_white/mongoid'
require 'black_and_white/mongoid/test'

module BlackAndWhite

  def self.create(args = {})
    Helpers::Broker.invoke(:create, args)
  end

  def self.add(klass, &block)
    klass.class_eval(&block)
  end
end
