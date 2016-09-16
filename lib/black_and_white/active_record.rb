require 'active_support/concern'
require 'black_and_white/active_record/error'

module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests,
                              class_name: '::BlackAndWhite::ActiveRecord::Test',
                              join_table: BlackAndWhite.config.bw_join_table,
                              association_foreign_key: :ab_test_id

      attr_reader :ab_test

      def ab_participate!(test_name, &block)
        if (@ab_test = fetch_ab_test(test_name)).present?
          if block_given?
            update_participant if block.call(self)
          else
            update_participant
          end
        else
          raise AbTestError, "no A/B Test with name #{test_name} exists"
        end
      end

      def participates?(test_name)
        ab_tests.where(name: test_name).any?
      end

      private

      def update_participant
        ab_tests << ab_test
      end

      def fetch_ab_test(name)
        BlackAndWhite::ActiveRecord::Test.find_by(name: name)
      end
    end
  end
end
