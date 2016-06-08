class Create<%= ab_tests_table_name.camelize%> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= ab_tests_table_name %> do |t|
      <%= ab_tests_table_data %>
    end
  end
end
