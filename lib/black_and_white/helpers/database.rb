module BlackAndWhite
  module Helpers
    module Database
      def bw_tests_table_data
        <<RUBY
          t.string :name, unique: true, null: false
          t.boolean :active, default: false
          t.timestamps null: false
RUBY
      end

      def bw_relations_table_data
        <<RUBY
        t.references :#{bw_tests_class_table_singularize}, index: true
        t.references :#{bw_tests_table_name_singularize}, index: true
RUBY
      end

      def bw_relations_table_name
        BlackAndWhite.config.bw_join_table
      end

      def bw_tests_table_name
        BlackAndWhite.config.bw_main_table
      end

      def bw_tests_table_name_singularize
        BlackAndWhite.config.bw_main_table.to_s.singularize
      end

      def bw_tests_class
        BlackAndWhite.config.bw_class
      end

      def bw_tests_class_table
        BlackAndWhite.config.bw_class_table
      end

      def bw_tests_class_table_singularize
        BlackAndWhite.config.bw_class_table.to_s.singularize
      end

      def bw_tests_table_name_pluralize
        BlackAndWhite.config.bw_main_table.to_s.pluralize
      end

      def migration_version
        if defined?(Rails) && Rails.version.start_with?('5')
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
