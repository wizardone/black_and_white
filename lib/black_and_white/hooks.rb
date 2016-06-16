module BlackAndWhite
  class Hooks
    def self.init
      if defined?(::ActiveRecord)
        require "black_and_white/active_record/test"
        require "black_and_white/active_record"
      end
    end
  end
end
