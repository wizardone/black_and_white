require 'rails/generators/active_record'

module BlackAndWhite
  module Generators
    class MigrationGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::Migration

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

