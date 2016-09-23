BlackAndWhite.configure do |config|
  config.bw_class = 'User'
  config.bw_class_table = :users
  config.bw_main_table = :ab_tests
  config.bw_join_table = :ab_tests_users
end
BlackAndWhite::Hooks.init
