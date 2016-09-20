require "black_and_white/version"
require "black_and_white/config"
require "black_and_white/hooks"
require "black_and_white/active_record"
require "black_and_white/active_record/error"
require "black_and_white/helpers/utils"

module BlackAndWhite
  def self.create(args = {})
    ActiveRecord::Test.create(args)
  end
end
