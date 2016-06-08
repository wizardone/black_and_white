class Create<%= ab_relations_table_name.camelize%> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= ab_relations_table_name %> do |t|
      <%= ab_relations_table_data %>
    end
  end
end
