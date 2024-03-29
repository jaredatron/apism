require 'apism/slop'

Apism::Application::Cli::Options = proc do |cli|

  Slop.new help: true, strict: true do

    on :v, :verbose, 'Enable verbose mode'

    run{ help! }

    command 'console' do

      run do
        require 'pry'
        Pry.start(cli)
      end

    end

    command 'sql' do

      run{ help! }

      command 'status' do

        run do
          puts "SQL STATSU HERE FOR APP #{cli.app}"
        end

      end

    end

  end


end
