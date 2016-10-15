require 'active_support/inflector'

module BlackAndWhite
  module ActiveRecord
    class Test < ::ActiveRecord::Base
      include Helpers::Methods
      self.table_name = BlackAndWhite.config.bw_main_table.to_s.pluralize

      validates :name, uniqueness: true

      has_and_belongs_to_many BlackAndWhite.config.bw_class_table,
                              join_table: BlackAndWhite.config.bw_join_table

    end
  end
end
