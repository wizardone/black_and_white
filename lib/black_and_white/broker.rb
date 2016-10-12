module BlackAndWhite
  class Broker

    class << self
      attr_accessor :orm

      def invoke(method, args = {})
        if orm == :active_record
          BlackAndWhite::ActiveRecord::Test.send(method, args)
        elsif orm == :mongoid
          BlackAndWhite::Mongoid::Test.send(method, args)
        end
      end

      def register(type)
        self.orm = type
      end
    end
  end
end
