module BlackAndWhite
  class Hooks
    def self.init
      ActiveSupport.on_load(:active_record) do
        require "black_and_white/active_record/participant"
        require "black_and_white/active_record/test"
      end
    end
  end
end
