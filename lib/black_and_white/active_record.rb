module BlackAndWhite
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :ab_tests, class_name: 'BlackAndWhite::ActiveRecord::Test'
    end
  end
end
