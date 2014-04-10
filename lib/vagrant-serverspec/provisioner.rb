# This implementation executes rspec in-process. Because rspec effectively
# takes ownership of the global scope, executing rspec within a child process
# may be preferred.
module VagrantPlugins
  module ServerSpec
    class Provisioner < Vagrant.plugin('2', :provisioner)
      def provision
        require_relative 'server_spec_runner'
        ServerSpecRunner.new(@machine).run
      end
    end
  end
end
