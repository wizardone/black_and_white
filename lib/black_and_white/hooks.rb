module BlackAndWhite
  class Hooks
    def self.init
      if defined?(::ActiveRecord)
        require 'black_and_white/active_record/test'
        require 'black_and_white/active_record'
      elsif defined?(::Mongoid)
        require 'black_and_white/mongoid/test'
        require 'black_and_white/mongoid'
      end
    end
  end
end
