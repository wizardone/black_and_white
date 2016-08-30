require 'active_support/concern'
require 'black_and_white/active_record/error'

module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests,
                              class_name: '::BlackAndWhite::ActiveRecord::Test',
                              join_table: BlackAndWhite.config.bw_join_table

      def participate(test_name, &block)
        ab_test = fetch_ab_test(test_name)
        if ab_test.present?
          ab_tests << ab_test
        else
          raise AbTestError, "no A/B Test with name #{test_name} exists"
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
