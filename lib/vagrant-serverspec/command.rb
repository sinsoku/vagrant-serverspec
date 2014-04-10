module VagrantPlugins
  module ServerSpec
    class Command < Vagrant.plugin('2', :command)
      def execute
        require_relative 'server_spec_runner'
        with_target_vms do |machine|
          ServerSpecRunner.new(machine).run
        end
      end
    end
  end
end
