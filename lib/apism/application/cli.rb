class Apism::Application::Cli

  autoload :Options, 'apism/application/cli/options'
  autoload :Sql,     'apism/application/cli/sql'

  def initialize app
    @app = app
  end
  attr_reader :app

  def options
    @options ||= Options[self]
  end

  def start! args=ARGV
    options.parse! args
  end

  def sql
    @sql ||= Sql.new(app)
  end

end
