require 'active_record'

module BlackAndWhite
  module ActiveRecord
    class Participant < ::ActiveRecord::Base
      self.table_name = BlackAndWhite.config.bw_main_table
    end
  end
end
