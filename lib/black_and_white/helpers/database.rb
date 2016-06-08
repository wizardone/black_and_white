module BlackAndWhite
  module Helpers
    module Database
      protected

      def ab_tests_table_name
        BlackAndWhite.config.bw_table.downcase
      end

      def ab_tests_table_data
        <<RUBY
          t.string :name, unique: true, null: false
          t.boolean :active, default: false
          t.references #{BlackAndWhite.config.bw_class.downcase}
          t.timestamps null: false
RUBY
      end

      def ab_relations_table_name
        [ab_tests_table_name, BlackAndWhite.config.bw_class.downcase.pluralize]
          .join('_')
      end

      def ab_relations_table_data
        <<RUBY
        t.integer :#{ab_tests_class}_id, null: false
        t.integer :#{ab_tests_table_name}_id, null: false
RUBY
      end

      def ab_tests_class
        BlackAndWhite.config.bw_class.downcase
      end

      def migration_version
        if Rails.version.start_with? '5'
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
