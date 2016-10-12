module BlackAndWhite
  module Mongoid
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests, class_name: 'BlackAndWhite::Mongoid::Test'

      attr_reader :ab_test, :options

      def ab_participate!(test_name, **options, &block)
        @options = options
        if (@ab_test = fetch_ab_test(test_name)).present?
          conditions = true
          conditions = yield(self) if block_given?
          update_participant if conditions
        else
          missing_ab_test(test_name)
        end
      end

      def ab_participates?(test_name)
        ab_tests.detect { |ab_test| ab_test.name == test_name }.present?
      end

      private

      def update_participant
        ab_tests << ab_test
      end

      def missing_ab_test(test_name)
        if options[:raise_on_missing]
          raise AbTestError, "no A/B Test with name #{test_name} exists or it is not active"
        end
        false
      end

      def fetch_ab_test(name)
        query = { name: name }
        if options[:join_inactive] == false
          query.merge!(active: true)
        end

        BlackAndWhite::ActiveRecord::Test.find_by(query)
      end
    end
  end
end
