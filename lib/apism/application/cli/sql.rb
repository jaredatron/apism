class Apism::Application::Cli::Sql

  def initialize(app)
    @app = app
  end
  attr_reader :app

  def configuration
    app.config(:sql)
  end

  def database_name
    configuration['database']
  end

end
