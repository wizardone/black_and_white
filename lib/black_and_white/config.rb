module BlackAndWhite

  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= BlackAndWhite::Config.new
  end

  class Config
    attr_accessor :bw_main_table, :bw_join_table, :bw_class, :bw_class_table

    def initialize
      @bw_main_table = :ab_tests
      @bw_join_table = :ab_tests_users
      @bw_class = 'User'
      @bw_class_table = :users
    end
  end
end
