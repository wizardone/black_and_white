module BlackAndWhite
  class Hooks
    def self.init
      ActiveSupport.on_load(:black_and_white_config_copied) do
        require "black_and_white/active_record/test"
        require "black_and_white/active_record"
      end
    end
  end
end
