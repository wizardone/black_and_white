module BlackAndWhite

  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= BlackAndWhite::Config.new
  end

  class Config
    attr_accessor :bw_main_table, :bw_join_table, :bw_class

    def initialize
    end
  end
end
