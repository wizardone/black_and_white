#require 'active_record/generators/migration'
require 'rails/generators/active_record'
require 'black_and_white/helpers/database'

module BlackAndWhite
  module Generators
    class MigrationsGenerator < Rails::Generators::Base # ActiveRecord::Generators::Base
      include Rails::Generators::Migration
      include BlackAndWhite::Helpers::Database
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
        Generator that copies the migrations for generating the a/b tests database table and relations into the
        main db/migrate workspace
DESC

      def copy_migration
        migration_template 'create_ab_tests_migration.rb', "db/migrate/create_#{ab_tests_table_name}.rb", migration_version: migration_version
        migration_template 'create_ab_tests_relation_migration.rb', "db/migrate/create_#{ab_relations_table_name}.rb", migration_version: migration_version
      end
    end
  end
end
