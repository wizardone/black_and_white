module BlackAndWhite
  module Helpers
    module Utils
      extend self

      def active_record_4?
        ::ActiveRecord::VERSION::MAJOR == 4
      end

      def active_record_5?
        ::ActiveRecord::VERSION::MAJOR == 5
      end

      def active_record_3?
        ::ActiveRecord::VERSION::MAJOR == 3
      end
    end
  end
end
