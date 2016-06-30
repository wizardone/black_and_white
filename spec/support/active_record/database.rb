require 'yaml'
db_name = ENV['TEST_DB'] || 'postgresql'
db_config = YAML.load_file(File.expand_path('../database_config.yml', __FILE__))

ActiveRecord::Base.configurations = db_config
if BlackAndWhite::Helpers::Utils.active_record_4? || BlackAndWhite::Helpers::Utils.active_record_5?
  ActiveRecord::Base.establish_connection(db_name.to_sym)
else
  ActiveRecord::Base.establish_connection(db_name)
end
