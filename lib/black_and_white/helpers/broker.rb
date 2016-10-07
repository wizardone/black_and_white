module BlackAndWhite
  module Helpers
    class Broker

      class << self
        attr_accessor :orm

        def invoke(method, args = {})
          if orm == :active_record
            ActiveRecord::Test.send(method, args)
          elsif orm == :mongoid
            Mongoid::Test.send(method, args)
          end
        end

        def register(type)
          self.orm = type
        end
      end
    end
  end
end
