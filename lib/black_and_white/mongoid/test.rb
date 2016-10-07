require 'mongoid' # WHY?
module BlackAndWhite
  module Mongoid
    class Test
      include ::Mongoid::Document
      field :name, type: String
      field :description, type: String
      field :active, type: Boolean, default: false
    end
  end
end
