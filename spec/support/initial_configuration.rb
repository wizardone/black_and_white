BlackAndWhite.configure do |config|
  config.bw_class = 'User'
  config.bw_main_table = :ab_tests
  config.bw_join_table = :ab_tests_users
end
