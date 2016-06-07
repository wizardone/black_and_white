module BlackAndWhite
  class Railtie < Rails::Railtie
    initializer "Black and white initializer" do
      puts "ouh, yeah"
    end
  end
end
