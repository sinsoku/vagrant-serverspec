require 'serverspec'

module VagrantPlugins
  module ServerSpec
    class ServerSpecRunner
      def initialize(machine)
        @machine = machine
        @spec_files = @machine.config.serverspec.spec_files

        RSpec.configure do |spec|
          spec.before :all do
            ssh_host                 = @machine.ssh_info[:host]
            ssh_username             = @machine.ssh_info[:username]
            ssh_opts                 = Net::SSH::Config.for(@machine.ssh_info[:host])
            ssh_opts[:port]          = @machine.ssh_info[:port]
            ssh_opts[:forward_agent] = @machine.ssh_info[:forward_agent]
            ssh_opts[:keys]          = @machine.ssh_info[:private_key_path]

            spec.ssh = Net::SSH.start(ssh_host, ssh_username, ssh_opts)
          end

          spec.after :all do
            spec.ssh.close if spec.ssh && !spec.ssh.closed?
          end
        end
      end

      def run
        RSpec::Core::Runner.run(@spec_files)
      end
    end
  end
end
