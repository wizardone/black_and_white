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
        # Fire the hooks here, after the config is copied. This allows all models
        # that rely on activerecord and the initializer config to be requested AFTER
        # the config file is present. Otherwise causes an exception. The load hook is
        # located in BlackAndWhite::Hooks
        ActiveSupport.run_load_hooks(:black_and_white_config_copied, self)
      end
    end
  end
end
