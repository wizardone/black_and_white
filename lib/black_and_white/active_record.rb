module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests,
                              class_name: 'BlackAndWhite::ActiveRecord::Test',
                              join_table: BlackAndWhite.config.bw_join_table,
                              association_foreign_key: 'ab_test_id'
    end
  end
end
