require "black_and_white/version"
require "black_and_white/config"
require "black_and_white/broker"

module BlackAndWhite

  def self.create(args = {})
    Broker.invoke(:create, args)
  end

  def self.add(klass, &block)
    klass.class_eval(&block)
  end
end
