class Create<%= bw_tests_table_name.to_s.camelize%> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= bw_tests_table_name %> do |t|
      <%= bw_tests_table_data %>
    end
  end
end
