require 'yaml'
require 'byebug'
db_name = ENV['TEST_DB'] || 'postgresql'
db_config = YAML.load_file(File.expand_path('../database_config.yml', __FILE__))

ActiveRecord::Base.configurations = db_config
config = ActiveRecord::Base.configurations[db_name]

begin
  if BlackAndWhite::Helpers::Utils.active_record_4? || BlackAndWhite::Helpers::Utils.active_record_5?
    ActiveRecord::Base.establish_connection(db_name.to_sym)
  else
    ActiveRecord::Base.establish_connection(db_name)
  end
  ActiveRecord::Base.connection
rescue
  case db_name
  when 'mysql'
    ActiveRecord::Base.establish_connection(config.merge('database' => nil))
    ActiveRecord::Base.connection.create_database(config['database'], { charset: 'utf8', collation: 'utf8_unicode_ci' })
  when 'postgresql'
    ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
    ActiveRecord::Base.connection.create_database(config['database'], config.merge('encoding' => 'utf8'))
  end
end
