require 'active_record'
require 'active_support/inflector'
require 'black_and_white/helpers/database'

module BlackAndWhite
  module ActiveRecord
    class Test < ::ActiveRecord::Base
      self.table_name = BlackAndWhite.config.bw_main_table.to_s.pluralize

      has_and_belongs_to_many BlackAndWhite.config.bw_class.downcase.pluralize.to_sym,
                              join_table: BlackAndWhite.config.bw_join_table
    end
  end
end
