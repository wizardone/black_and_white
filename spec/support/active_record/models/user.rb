class User < ActiveRecord::Base
  include BlackAndWhite::ActiveRecord

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
