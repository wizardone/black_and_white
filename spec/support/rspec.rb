require 'database_cleaner'

RSpec.configure do |config|
  if ENV['BAW_MONGOID']
    config.filter_run_excluding activerecord: true
  end

  if ENV['BAW_ACTIVERECORD']
    config.filter_run_excluding mongoid: true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
