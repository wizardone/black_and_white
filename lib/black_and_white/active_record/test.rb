require 'active_record'
require 'active_support/inflector'

module BlackAndWhite
  module ActiveRecord
    class Test < ::ActiveRecord::Base
      self.table_name = BlackAndWhite.config.bw_main_table.to_s.pluralize

      validates :name, uniqueness: true

      has_and_belongs_to_many BlackAndWhite.config.bw_class_table,
                              join_table: BlackAndWhite.config.bw_join_table

      def activate!
        self.active = true
        save!
      end

      def deactivate!
        self.active = false
        save!
      end
    end
  end
end
