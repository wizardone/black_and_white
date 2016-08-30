module BlackAndWhite
  class Railtie < ::Rails::Railtie
    initializer "Black And White load classes after ActiveRecord" do |app|
      # Not used at the moment
      # BlackAndWhite::Hooks.init
    end
  end
end
