require 'active_support/concern'
module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests,
                              class_name: '::BlackAndWhite::ActiveRecord::Test',
                              join_table: BlackAndWhite.config.bw_join_table,
                              association_foreign_key: 'ab_test_id'

      def participate(ab_test, &block)
        if ab_test_exists?(ab_test)
          self.ab_tests.create!(ab_test_id: BlackAndWhite::ActiveRecord::Test.find_by(name: ab_test).id)
        else
          raise "no A/B Test with name #{ab_test} exists"
        end
      end

      private
      def ab_test_exists?(ab_test)
        BlackAndWhite::ActiveRecord::Test.exists?(name: ab_test)
      end
    end
  end
end
