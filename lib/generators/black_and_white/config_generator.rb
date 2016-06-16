module BlackAndWhite
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc  <<DESC
        Generator that copies the default BlackAndWhite config into the
        initializers folder
DESC

      def copy_config
        copy_file 'black_and_white_config.rb', 'config/initializers/black_and_white.rb'
      end
    end
  end
end
