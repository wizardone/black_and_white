class User < ActiveRecord::Base
  include BlackAndWhite::ActiveRecord
  #attr_accessor :active, :gender, :name

  def active
    true
  end

  def gender
    'm'
  end

  def name
    'Stefan'
  end
end
