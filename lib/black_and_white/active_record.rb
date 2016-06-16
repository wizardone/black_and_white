require 'active_support/concern'
module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests,
                              class_name: '::BlackAndWhite::ActiveRecord::Test',
                              join_table: BlackAndWhite.config.bw_join_table,
                              association_foreign_key: 'ab_test_id'

      def participate(test_name, &block)
        if ab_test = fetch_ab_test(test_name)
          ab_tests << ab_test
        else
          raise "no A/B Test with name #{ab_test} exists"
        end
      end

      def participates?(test_name)
        ab_tests.where(name: test_name).any?
      end

      private

      def fetch_ab_test(name)
        BlackAndWhite::ActiveRecord::Test.find_by(name: name)
      end
    end
  end
end
