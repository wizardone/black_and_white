module BlackAndWhite
  class Hooks
    def self.init
      require 'black_and_white'
      require 'black_and_white/error'
      if defined?(::ActiveRecord)
        BlackAndWhite::Broker.register(:active_record)
        require 'black_and_white/active_record'
        require 'black_and_white/active_record/test'
        require 'black_and_white/helpers/active_record/utils'
        require 'black_and_white/helpers/active_record/database'
      elsif defined?(::Mongoid)
        BlackAndWhite::Broker.register(:mongoid)
        require 'black_and_white/mongoid'
        require 'black_and_white/mongoid/test'
      end
    end
  end
end
