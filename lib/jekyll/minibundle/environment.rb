module Jekyll::Minibundle
  module Environment
    class << self
      def command_for(type)
        key = "JEKYLL_MINIBUNDLE_CMD_#{type.upcase}"
        cmd = ENV[key]
        fail "You need to set command for minification in $#{key}" if !cmd
        cmd
      end

      def development?
        ENV['JEKYLL_MINIBUNDLE_MODE'] == 'development'
      end
    end
  end
end
