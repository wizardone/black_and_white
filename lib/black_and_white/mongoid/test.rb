module BlackAndWhite
  module Mongoid
    class Test
      include ::Mongoid::Document
      include Helpers::Methods

      has_and_belongs_to_many BlackAndWhite.config.bw_class_table

      field :name, type: String
      field :description, type: String
      field :active, type: Boolean, default: false

      validates :name, uniqueness: true
    end
  end
end
