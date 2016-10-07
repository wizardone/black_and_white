module BlackAndWhite
  class Hooks
    def self.init
      if defined?(::ActiveRecord)
        Helpers::Broker.register(:active_record)

        require 'black_and_white/active_record/test'
        require 'black_and_white/active_record'
      elsif defined?(::Mongoid)
        Helpers::Broker.register(:mongoid)

        require 'black_and_white/mongoid/test'
        require 'black_and_white/mongoid'
      end
    end
  end
end
