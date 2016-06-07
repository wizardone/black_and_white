class Create<%= table_name.camelize%> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
      t.timestamps null: false
    end
  end
end

