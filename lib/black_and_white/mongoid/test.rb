module BlackAndWhite
  module Mongoid
    class Test
      include ::Mongoid::Document
      has_and_belongs_to_many BlackAndWhite.config.bw_class_table

      field :name, type: String
      field :description, type: String
      field :active, type: Boolean, default: false

      validates :name, uniqueness: true

      def activate!
        self.active = true
        save!
      end

      def deactivate!
        self.active = false
        save!
      end
    end
  end
end
