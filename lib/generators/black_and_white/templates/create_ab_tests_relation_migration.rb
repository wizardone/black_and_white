class Create<%= bw_relations_table_name.to_s.camelize%> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= bw_relations_table_name %> do |t|
      <%= bw_relations_table_data %>
    end
  end
end
