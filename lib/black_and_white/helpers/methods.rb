module BlackAndWhite
  module Helpers
    module Methods
      # Common methods, shared between activerecord and mongoid
      def activate!
        self.active = true
        save!
      end

      def deactivate!
        self.active = false
        save!
      end
    end
  end
end
