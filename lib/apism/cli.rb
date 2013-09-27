require 'apism'
require 'slop'


require 'pry'

class Slop
  def help!
    puts help
    exit!
  end
end

Apism::Cli = Slop.new help: true, strict: true do

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

end
