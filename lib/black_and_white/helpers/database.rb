module BlackAndWhite
  module Helpers
    module Database
      protected

      def bw_tests_table_name
        BlackAndWhite.config.bw_table
      end

      def bw_tests_table_data
        <<RUBY
          t.string :name, unique: true, null: false
          t.boolean :active, default: false
          t.references #{bw_tests_class.downcase}
          t.timestamps null: false
RUBY
      end

      def bw_relations_table_name
        [bw_tests_table_name, bw_tests_class.downcase.pluralize]
          .join('_')
      end

      def bw_relations_table_data
        <<RUBY
        t.integer :#{bw_tests_class.downcase}_id, null: false
        t.integer :#{bw_tests_table_name}_id, null: false
RUBY
      end

      def bw_tests_class
        BlackAndWhite.config.bw_class
      end

      def migration_version
        if Rails.version.start_with? '5'
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
