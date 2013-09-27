require 'apism/slop'

Apism::Cli::Options = Slop.new help: true, strict: true do

  on :v, :verbose, 'Enable verbose mode'

  on :version, 'Print the version' do
    puts Apism::VERSION
  end

  run{ help! }

  command 'new' do
    banner 'Usage: apism new APP_NAME [options]'
    run do |opts, (name)|
      help! if name.nil? || name.empty?
      puts "Creating #{name}"
    end
  end

  command 'sql' do

    run{ help! }

    command 'status' do

      run do
        puts "SQL STATSU HERE"
      end

    end

  end

end
