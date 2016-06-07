#require 'active_record/generators/migration'
require 'rails/generators/active_record'

module BlackAndWhite
  module Generators
    class MigrationGenerator < Rails::Generators::Base # ActiveRecord::Generators::Base
      include Rails::Generators::Migration
      # include ActiveRecord::Generators::Migration
      # For some reason including ActiveRecord::Generators::Migration causes
      # the generator to not appear when calling `rails g`.
      # ActiveRecord::Generators::Migration already implements the `next_migration_number` and
      # includes Rails::Generators::Migration in itself, so it woulda been a lot easier to just include
      # it here. However this does not seem possible so we just evaluate the same method directly in
      # Rails::Generators::Migration
      Rails::Generators::Migration::ClassMethods.class_eval do
        def next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end
      end

      source_root File.expand_path('../templates', __FILE__)

      desc  <<DESC
        Generator that copies the migration for generating the a/b tests database table
DESC

      def copy_migration
        migration_template 'black_and_white_migration.rb', "db/migrate/create_#{table_name}.rb", migration_version: migration_version
      end

      protected

      def table_name
        BlackAndWhite.config.bw_table
      end

      def migration_version
        if Rails.version.start_with? '5'
         "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end

