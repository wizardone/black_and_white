class User
  include ::Mongoid::Document
  include BlackAndWhite::Mongoid

  field :active, type: Boolean, default: true
  field :name, type: String
  field :gender, type: String
end
