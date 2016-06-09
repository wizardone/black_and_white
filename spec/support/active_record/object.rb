require 'black_and_white/helpers/database'
module Support
  module ActiveRecord
    class Object
      include BlackAndWhite::Helpers::Database
    end
  end
end
